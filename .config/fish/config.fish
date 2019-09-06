set fish_emoj_width 2
set fish_ambiguous_width 1
set -gx GOPATH $HOME/dev/golang
set -gx GOBIN $GOPATH/bin

set -gx EDITOR /bin/nvim
set -gx TERMINAL /usr/local/bin/st
set -gx BROWSER /usr/bin/brave-dev
set -gx READER /usr/bin/zathura

set PATH $GOPATH $GOBIN $PATH  $HOME/.local/bin/ $HOME/.cargo/bin $HOME/.local/bin/i3blocks/

source ~/.aliases

# Start X at login
# if status is-login
#     if test -z "$DISPLAY" -a $XDG_VTNR = 1
#         exec startx -- -keeptty
#     end
# end
