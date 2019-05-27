#! /bin/sh

# exec i3
#xrdb ~/.Xresources
remaps&
dunst&


''> /home/machine/.isdwmrunning
rs&
programming-mode&
unclutter&
mpd&
bardwm&
sxhkd&
nm-applet&
while : ; do
    dwm 2>&1 | sed -e "s/^/$(date +%Y-%m-%d_%T) /" >> ~/dwmlogs
    sleep 1
    [ -s "/home/machine/.isdwmrunning" ] && break
done
