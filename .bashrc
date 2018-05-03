#
# ~/.bashrc
#

###
# Windows only Config
###
export STARTUP='/c/Users/Michael/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# included as a folder executables are run from 
	export PATH=$PATH:~/.gem/ruby/2.2.0/bin
	export PATH=$PATH:~/.bin
	
####
# SHELL BEHAVIOUR
####

# Allow use of globstart '**' to glob recursively through directories
	shopt -s globstar

####
# HISTORY
####

# Each of these keeps history clean of unimportant commands
	HISTIGNORE="ls:[bf]g:exit:pwd:clear:less:umount:oh"

# If a command starts with a space or is a duplicate, don't add it to history
	HISTCONTROL=ignoreboth

# Let the history size be reasonably sized
	HISTFILESIZE=1000000
	HISTSIZE=1000000

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
	loadkeys ~/.keymap

	## Command-specific config ##

####
# ALIASES
####

# Easier way of doing "sudo !!"
	alias oh='sudo $(history -p \!\!)'

# Makes the "ls" command all pretty
	alias ls='ls --color=auto'

# user personal vim config whenever running vim as superuser
	alias suvim='sudo vim -u ~/.vimrc'

####
# STARTUP
####
# And then start x (If on the first display)
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
