#!/bin/sh

[ -z $userresources ] && userresources=$HOME/.Xresources
[ -z $usermodmap ] && usermodmap=$HOME/.Xmodmap
[ -z $sysresources ] && sysresources=/etc/X11/xinit/.Xresources
[ -z $sysmodmap ] && sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xinput set-prop "DualPoint Stick" "Evdev Wheel Emulation" 1
xinput set-prop "DualPoint Stick" "Evdev Wheel Emulation Button" 2
xinput set-prop "DualPoint Stick" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "DualPoint Stick" "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop "DualPoint Stick" "Device Accel Constant Deceleration" 1.00
command -v setxkbmap && setxkbmap -option caps:escape
#setxkbmap -option grp:alts_toggle

function tryinit { command -v "$1" && "$@" & }

# Utilities
tryinit lxpolkit
tryinit kdeconnectd # Usually in /lib, only runs if the exec has been linked

# System tray
tryinit kdeconnect-indicator
tryinit xfce4-power-manager
tryinit pasystray

# Display
tryinit redshift
[ -f ~/.fehbg ] && sh ~/.fehbg
i3
#exec startlxde
