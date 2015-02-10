#
# ~/.bashrc
#

# If not running interactively, don't do anything
	[[ $- != *i* ]] && return


#remaps Caps Lock to Escape.

#This one's for CLI
	loadkeys ~/.keymap

#This one's for X (doesn't work till bash is open)
	setxkbmap -option caps:escape

	
	## Command-specific config ##

#easier way of doing "sudo !!"
	alias oh='sudo $(history -p \!\!)'
#doesnt save "oh" to history
	export HISTIGNORE=oh

#makes the "ls" command all pretty
	alias ls='ls --color=auto'
	
#each of these keeps history clean of unimportant commands
#the [ \t]* at the end means it includes anything following
	HISTIGNORE="&:ls:[bf]g:exit:pwd:clear:mount:umount:[ \t]*"	
#

#just a general prompt. Gotta customise this sometimes...
	PS1='[\u@\h \W]\$ '
/bin/bash: line 0: fg: no job control
