#!/bin/sh

#export PATH="$PATH:$HOME/.scripts/
#export EDITOR="nvim"
#export TERMINAL="st"
#export BROWSER="brave-beta"
#export TRUEBROWSER="brave-beta"
#export READER="zathura"
PS1="\[\033[38;5;160m\][\W] \[$(tput sgr0)\]"
export PS1

#[ -f ~/.bashrc ] && source ~/.bashrc

#export PATH="$HOME/.cargo/bin:$PATH"
#exec fish
# Start graphical server if i3 not already running.
#if [ "$(tty)" = "/dev/tty1" ]; then
#	pgrep -x dwm || exec startx
#fi

