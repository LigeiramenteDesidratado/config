#! /bin/sh

# exec i3
# xrdb ~/.Xresources

remaps&
dunst&
mpd&
unclutter&
dwmbar&
rs&
backup&
# clipmenud&
echo '' > /home/machine/.isdwmrunning
while : ; do

    #with logs
    # dwm 2>&1 | sed -e "s/^/$(date '+[%Y-%m-%d] [%T]') /" >> ~/dwmlogs
    dwm > /dev/null
    [ -s "/home/machine/.isdwmrunning" ] && break
    sleep 1
done
