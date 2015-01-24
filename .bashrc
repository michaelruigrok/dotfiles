#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#remaps Caps Lock to Escape.(X one
  #This one's for CLI
loadkeys ~/.keymap
  #This one's for X (doesn't work till bash is open)
setxkbmap -option caps:escape


#Command-specific config
alias oh='sudo $(history -p \!\!"'

#makes the "ls" command all pretty
alias ls='ls --color=auto'

#easier way of doing "sudo !!"


#just a general prompt. Gotta customise this sometimes...
PS1='[\u@\h \W]\$ '

