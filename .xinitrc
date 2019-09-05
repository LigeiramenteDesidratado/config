#! /bin/sh

# exec i3
# xrdb ~/.Xresources

remaps&
rs&
dunst&
/usr/bin/xwallpaper --zoom "$HOME/wallpapers/roses.jpg"
unclutter&
sxhkd > /dev/null 2>&1 &
''> /home/machine/.isdwmrunning
mpd&
dwmbar&
nm-applet&
while : ; do
    dwm 2>&1 | sed -e "s/^/$(date '+[%Y-%m-%d] [%T]') /" >> ~/dwmlogs
    [ -s "/home/machine/.isdwmrunning" ] && break
    sleep 1
done
