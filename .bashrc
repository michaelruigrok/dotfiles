#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# included as a folder executables are run from 
	export PATH=$PATH:/home/mruig1/.gem/ruby/2.2.0/bin

 # Remaps Caps Lock to Escape.

# This one's for CLI (must be root)
	loadkeys ~/.keymap

# This one's for X (doesn't work till bash is open)
	setxkbmap -option caps:escape

	
	## Command-specific config ##

# Easier way of doing "sudo !!"
	alias oh='sudo $(history -p \!\!)'

# Makes the "ls" command all pretty
	alias ls='ls --color=auto'
	
# Each of these keeps history clean of unimportant commands
# The [ \t]* at the end means it includes anything following
	HISTIGNORE="&:ls:[bf]g:exit:pwd:clear:less:mount:umount:oh:uptime:[ \t]*"	

# Favourite editor:
export EDITOR="vim"

# Just a general prompt. Gotta customise this sometimes...
	PS1='[\u@\h \W]\$ '
