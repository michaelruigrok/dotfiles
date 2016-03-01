#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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
#setxkbmap -option caps:escape
#setxkbmap -option grp:alts_toggle
sh /home/deco1400/.fehbg
xfce-power-manager
i3
pasystray
#exec startlxde
