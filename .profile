#!/bin/sh

# Profile file. Runs on login.

export PATH="$PATH:$HOME/.scripts"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="linkhandler"
export TRUEBROWSER="brave"
export READER="zathura"

[ -f ~/.bashrc ] && source ~/.bashrc

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
	pgrep -x i3 || exec startx
fi

# Switch escape and caps and use wal colors if tty:
sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null
tty | grep tty >/dev/null && wal -Rns

# To avoid potential situation where cdm(1) crashes on every TTY, here we
# default to execute cdm(1) on tty1 only, and leave other TTYs untouched.
if [[ "$(tty)" == '/dev/tty1' ]]; then
    [[ -n "$CDM_SPAWN" ]] && return
    # Avoid executing cdm(1) when X11 has already been started.
    [[ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ]] && exec cdm
fi

