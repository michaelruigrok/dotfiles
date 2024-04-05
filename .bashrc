# ~/.bashrc

onExit() {
	history -p "EXIT $(date -I)"
}

trap onExit EXIT

###
# Windows only Config
###
if [ `uname -o` = "Msys" ]; then
	export WINUSER="${WINUSER:-$USER}"
	export WINHOME="/c/Users/$WINUSER"
elif [ "$WSL_DISTRO_NAME" ]; then
	export WINUSER="${WINUSER:-$USER}"
	export WINHOME="/mnt/c/Users/$WINUSER"
fi

if [ "$WINHOME" ]; then
	export STARTUP="$WINHOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# load shell source files
source_libs() {
	for file in ~/.local/lib/shell/*; do
		source "$file"
	done
}
source_libs

####
# SHELL BEHAVIOUR
####

	COLOR='\[\033[01'  # Start colour 2
	ENDCOLOR='\[\033[00m\]'

	PS1='\d \t\n'       # date/time
	PS1+=''
	PS1+="$COLOR;32m\]" # Start colour 1
	PS1+='\u@\h'        # user@host
	PS1+="$ENDCOLOR:$COLOR;35m\]"
	PS1+='\W'           # Working directory tail
	PS1+="$ENDCOLOR\$ "

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

# Favourite editor:
	export EDITOR="vim"

## Remaps Caps Lock to Escape.
# This one's for CLI (must be root)
	loadkeys ~/.keymap 2>/dev/null


####
# HISTORY
####

# Each of these keeps history clean of unimportant commands
	HISTIGNORE="ls:[bf]g:exit:pwd:clear:less:umount:oh"

# If a command starts with a space or is a duplicate, don't add it to history
	HISTCONTROL=ignoreboth

# Let the history size be reasonably sized
	HISTSIZE=-1
	unset HISTFILESIZE

# Append to HISTFILE, rather than overriding it
	shopt -s histappend

# Record each line of history as it is issued
	PROMPT_COMMAND='history -a'

####
# Application env
####

export LESS='-i'

export RLWRAP_HOME=$HOME/.config/readline

####
# ALIASES
####

# $1 -- alias name match (exact)
# $2 -- resulting command prefix match (currently first line only)
histignore_alias() {
	var_a HISTIGNORE $(alias | sed -nE "/^alias ($1)='$2.*/s//\1/p")
}

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

	function git() {
		if [ "$1" = "recent-branches" ]; then
			command git branch --all --sort=-committerdate | grep remote | head -n 5
		else
			command git "$@"
		fi
	}

alias k='kubectl'
complete -F __start_kubectl k

# To see k8s secret data in plaintext
	function kubeSecret() {
		[ -z "$1" ] && "arg 1: secret name"
		[ -z "$2" ] && "arg 2: secret key"
		kubectl get secret $1 -o jsonpath="{.data.$2}" | base64 --decode; echo
	}

alias k='kubectl'
complete -F __start_kubectl k

alias use-context='kubectl config use-context'
alias set-namespace='kubectl config set-context --current --namespace'
alias kns='kubectl config set-context --current --namespace'
alias get-contexts='kubectl config get-contexts'
alias kg='kubectl get pods'
alias kgb='kubectl get pods -n beta'
alias kgp='kubectl get pods -n prod'

alias kg='kubectl get pods'
alias kgb='kubectl get pods -n beta'
alias kgp='kubectl get pods -n prod'
histignore_alias k[g].* kubectl

alias g='git'
alias gs='git status'
alias gsh='git show'
alias ga='git add'
alias gap='git add -p'
alias gd='git diff'
alias gd-='git diff --'
alias gd.='git diff -- .'
alias gds='git diff --staged'
alias gch-='git checkout --'
histignore_alias g.* git
HISTIGNORE+=":gch-*"


# I always type stuff wrong
	alias kubect='kubectl'
	alias kubetl='kubectl'

	unset SSH_ASKPASS

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

	weather() { curl "wttr.in/$(echo ${*:-Brisbane City} | sed 's/ /%20/')"; }

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# included as a folder executables are run from
	export PATH=~/.bin:$PATH
	export PATH=~/.local/bin:$PATH
	export PATH="~/.yarn/bin:$PATH"


####
# STARTUP
####

# And then start x (If on the first display)
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

