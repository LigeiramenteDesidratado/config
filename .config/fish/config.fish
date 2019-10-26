set fish_emoj_width 2
set fish_ambiguous_width 1
set -gx GOPATH $HOME/dev/golang
set -gx GOBIN $GOPATH/bin

set -gx EDITOR /bin/nvim
set -gx TERMINAL /usr/local/bin/st
set -gx BROWSER /usr/bin/brave-dev
set -gx READER /usr/bin/zathura

set -gx FZF_DEFAULT_OPTS '--bind alt-k:preview-up,alt-j:preview-down --height=70% --preview="ccat --force {}" --preview-window=right:60%:wrap'
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND

set PATH $GOPATH $GOBIN $PATH $HOME/.local/bin/ $HOME/.cargo/bin $HOME/.local/bin/i3blocks/ (yarn global bin)

bind -M insert \co __fzf_open
bind -M insert \cf forward-char
bind -M default \cf forward-char
bind -M visual \cf forward-char

set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")
source ~/.aliases

# Start Wayland at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec sway
    end
end

#yay --editmenu --removemake --sudoloop --save
