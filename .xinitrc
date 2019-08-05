#! /bin/sh

# exec i3
# xrdb ~/.Xresources

remaps&
rs&
dunst&
/usr/bin/xwallpaper --zoom "$HOME/wallpapers/roses.jpg"
unclutter&

# rm ~/.config/sxhkd/sxhkdrc
# ln -s ~/.config/sxhkd/sxhkdrc_normal ~/.config/sxhkd/sxhkdrc
sxhkd > /dev/null 2>&1 &

''> /home/machine/.isdwmrunning
# # programming-mode&
mpd&
dwmbar&
# ~/.config/howm/bar.sh &
# howm -c ~/.config/howm/howmrc
# spectrwm
# # custard
nm-applet&
# sway
while : ; do
    dwm 2>&1 | sed -e "s/^/$(date '+[%Y-%m-%d] [%T]') /" >> ~/dwmlogs
    [ -s "/home/machine/.isdwmrunning" ] && break
    sleep 1
done
