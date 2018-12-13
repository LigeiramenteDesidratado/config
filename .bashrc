#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

export PS1="\[$(tput bold)\]\[\033[38;5;11m\]\W > \[$(tput sgr0)\]"

export GPG_TTY=$(tty)

# System Maintainence
alias sdn="sudo shutdown now"
alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg

# Some aliases
alias tixati="$HOME/programs/Tixati_portable/tixati_Linux64bit &"
alias p="sudo pacman"
alias SS="sudo systemctl"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias mkd="mkdir -pv"
alias ref="shortcuts.sh && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias bw="wal -i ~/.config/wall.png" # Rerun pywal
alias pi="bash ~/.larbs/wizard/wizard.sh"
alias g="go run"
alias mp="mpv --sub-font-size=35 "

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.

# Internet
alias YT="youtube-dl --add-metadata -ic" # Download video link
alias yta="YT -x -f bestaudio/best" # Download only audio
alias yt="youtube-viewer -7"
alias ethspeed="speedometer -r enp0s25"
alias wifispeed="speedometer -r wlp3s0"
alias starwars="telnet towel.blinkenlights.nl"

source ~/.shortcuts

shdl() { curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf) ;}

# Python env
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# Golang env
export GOPATH=$HOME/dev/golang/goworkspace
export GOBIN=$GOPATH/bin

# history with data
export HISTTIMEFORMAT="%d/%m/%y %T "

