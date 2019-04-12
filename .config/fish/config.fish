
set -gx GOPATH $HOME/dev/golang/goworkspace
set -gx GOBIN $GOPATH/bin

set -gx EDITOR /bin/nvim
set -gx TERMINAL /usr/local/bin/st
set -gx BROWSER /usr/bin/brave-dev
set -gx READER /usr/bin/zathura
set -gx COCOS_X_ROOT /opt/cocos2d-x
set -gx COCOS_CONSOLE_ROOT $COCOS_X_ROOT/tools/cocos2d-console/bin
set -gx COCOS_TEMPLATES_ROOT $COCOS_X_ROOT/templates
set PATH $GOPATH $GOBIN $COCOS_X_ROOT $COCOS_CONSOLE_ROOT $COCOS_TEMPLATES_ROOT $PATH /home/machine/.scripts/ $HOME/.cargo/bin

source ~/.aliases

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
