#!/bin/bash

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

# export PS1="\[$(tput bold)\]\[\033[38;5;11m\]\W > \[$(tput sgr0)\]"
export PS1="\[\033[38;5;160m\][\W] \[$(tput sgr0)\]"
export GPG_TTY=$(tty)

source ~/.aliases
function c {
    builtin cd "$@" && clear && ls
}

function mgo {
	mkdir "$@" -v && clear && cd "$@"
}
# Python env
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Golang env
export GOPATH=$HOME/dev/golang/goworkspace
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin
# history with data
export HISTTIMEFORMAT="%d/%m/%y %T "


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
