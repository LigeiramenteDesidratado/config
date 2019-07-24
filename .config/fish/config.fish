set fish_emoj_width 2
set fish_ambiguous_width 1
set -gx GOPATH $HOME/dev/golang/goworkspace
set -gx GOBIN $GOPATH/bin

set -gx EDITOR /bin/nvim
set -gx TERMINAL /usr/local/bin/st
set -gx BROWSER /usr/bin/brave-dev
set -gx READER /usr/bin/zathura
# set -gx BRAVE_FLAGS --kiosk
set PATH $GOPATH $GOBIN $COCOS_X_ROOT $COCOS_CONSOLE_ROOT $COCOS_TEMPLATES_ROOT $PATH $HOME/.scripts/ $HOME/.local/bin/ $HOME/.cargo/bin $HOME/.scripts/i3blocks/ (yarn global bin)

source ~/.aliases

 # Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
