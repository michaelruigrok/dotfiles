#
# ~/.bashrc
#

###
# Windows only Config
###
if [ `uname -o` = "Msys" ]; then
	export STARTUP='/c/Users/Michael/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup'

fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# included as a folder executables are run from
	export PATH=~/.bin:$PATH

####
# SHELL BEHAVIOUR
####

# Allow use of globstart '**' to glob recursively through directories
	shopt -s globstar

# ctrl-s searches forward in history, instead of pausing the terminal
	stty -ixon

# bash auto-completion
source_if_exists() { [ -f "$1" ] && source $1;}
if ! shopt -oq posix; then
	source_if_exists /usr/share/bash-completion/bash_completion
	source_if_exists /etc/bash_completion
	source_if_exists /etc/profile.d/bash_completion.sh
fi

# more autocomplete support
	command -v kubectl >/dev/null && source <(kubectl completion bash)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

####
# HISTORY
####

# Each of these keeps history clean of unimportant commands
	HISTIGNORE="ls:[bf]g:exit:pwd:clear:less:umount:oh"

# If a command starts with a space or is a duplicate, don't add it to history
	HISTCONTROL=ignoreboth

# Let the history size be reasonably sized
	HISTFILESIZE=10000000
	HISTSIZE=10000000

# Append to HISTFILE, rather than overriding it
	shopt -s histappend

# Record each line of history as it is issued
	PROMPT_COMMAND='history -a'

# Favourite editor:
	export EDITOR="vim"

# Just a general prompt. Gotta customise this sometimes...
	PS1='[\u@\h \W]\$ '

## Remaps Caps Lock to Escape.

# This one's for CLI (must be root)
	loadkeys ~/.keymap 2>/dev/null

	## Command-specific config ##

####
# ALIASES
####

# Easier way of doing "sudo !!"
	alias oh='sudo $(history -p \!\!)'

# Make some commands pretty
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'

# user personal vim config whenever running vim as superuser
	alias suvim='sudo vim -u ~/.vimrc'

# Common typo shortening I may as well use
	alias chmox='sudo chmod +x'

# the command 'cd.. [number]' will go up directories the specified number of times
	function cd_up() {
		cd $(printf "%0.0s../" $(seq 1 $1));
	}
	alias 'cd..'='cd_up'

	alias bye='shutdown now'

	alias mygrep='grep --exclude-dir=node_modules'

	alias docc='docker-compose'

	alias docclogs='docc logs -f --tail=40 | ccze -m ansi'

# I always type git checkout wrong
	alias chekcout='checkout'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

	weather() { curl "wttr.in/${*:-Brisbane City}"; }

####
# STARTUP
####

# And then start x (If on the first display)
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

