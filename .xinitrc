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
sxhkd > /dev/null 2>&1 &
nm-applet&
while : ; do
    dwm 2>&1 | sed -e "s/^/$(date '+[%Y-%m-%d] [%T]') /" >> ~/dwmlogs
    [ -s "/home/machine/.isdwmrunning" ] && break
    sleep 1
done
