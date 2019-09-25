set fish_emoj_width 2
set fish_ambiguous_width 1
set -gx GOPATH $HOME/dev/golang
set -gx GOBIN $GOPATH/bin

set -gx EDITOR /bin/nvim
set -gx TERMINAL /usr/local/bin/st
set -gx BROWSER /usr/bin/brave-dev
set -gx READER /usr/bin/zathura
# set -gx FZF_FIND_FILE_COMMAND "rg --files --no-ignore-vcs --hidden"
# set -gx FZF_OPEN_COMMAND "rg --files --no-ignore-vcs --hidden"

# set -gx  FZF_DEFAULT_OPTS '--height=50% --preview="bat --color \"always\" {}" --preview-window=right:60%:wrap'
set -gx  FZF_DEFAULT_OPTS '--bind alt-k:preview-up,alt-j:preview-down --height=50% --preview="ccat --force {}" --preview-window=right:60%:wrap'
set -gx  FZF_DEFAULT_COMMAND "rg --files"
set -gx  FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set PATH $GOPATH $GOBIN $PATH  $HOME/.local/bin/ $HOME/.cargo/bin $HOME/.local/bin/i3blocks/ (yarn global bin)

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

source ~/.aliases

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec sway
    end
end
