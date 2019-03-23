#!/bin/sh

# Profile file. Runs on login.

export PATH="$PATH:$HOME/.scripts"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave-dev"
export TRUEBROWSER="brave-dev"
export READER="zathura"

[ -f ~/.bashrc ] && source ~/.bashrc

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x dwm || exec startx
fi

# Switch escape and caps and use wal colors if tty:
sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null
tty | grep tty >/dev/null && wal -Rns


export PATH="$HOME/.cargo/bin:$PATH"
