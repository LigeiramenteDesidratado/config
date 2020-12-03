
DISABLE_MAGIC_FUNCTIONS=true

COMPLETION_WAITING_DOTS="true"

export HISTFILE=$HOME/.zsh_history

## User configuration
export GOPATH=$HOME/dev/golang
export GOBIN=$GOPATH/bin
export EDITOR=/bin/nvim
export TERMINAL=/usr/local/bin/st
export BROWSER=brave
export READER=/usr/bin/zathura
export PATH=$PATH:$GOPATH:$GOBIN:$HOME/.local/bin/:$HOME/.cargo/bin:$HOME/.local/bin/i3blocks:$HOME/.local/bin/cron:$HOME/.yarn/bin/
source ~/.aliases

export PATH=$PATH:/usr/local/go/bin

export TERM=st-256color
export COLORTERM=24bit

#Fzf related
export FZF_DEFAULT_OPTS="--bind alt-k:preview-up,alt-j:preview-down --inline-info"
export FZF_CTRL_T_OPTS='--height=70% --preview="ccat --color=always {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND="rg --files --no-messages --no-ignore --no-ignore-vcs --hidden -S --glob !.git --glob !node_modules --glob !.ccls-cache "
export FZF_CTRL_R_OPTS="--height=20% "
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_OPEN_COMMAND=$FZF_DEFAULT_COMMAND

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export _JAVA_AWT_WM_NONREPARENTING=1
export WALLCMD="/usr/bin/xwallpaper --daemon --zoom "

# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

function fzf_open {
    eval "$FZF_OPEN_COMMAND |" fzf $FZF_CTRL_T_OPTS | xargs -ro $EDITOR
}
zle -N fzf_open fzf_open
bindkey '^o' fzf_open
function c {
    builtin cd "$@" && clear && l
}

function gt {
  go test -v $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/RUN/s//$(printf "\033[34mRUN\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

bindkey -v

setopt extendedGlob
setopt promptsubst

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


#------------------------------
# Comp stuff
#------------------------------
autoload -Uz compinit
compinit

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

export KEYTIMEOUT=1

HISTSIZE=100000
SAVEHIST=100000

# Keep history of `cd` as in with `pushd` and make `cd -<TAB>` work.
DIRSTACKSIZE=16
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{120}[%f%F{255}%K{236}%b%F{214}%m%u%c%f%k%F{120}]%f"

precmd() {
    vcs_info
}

setprompt() {
  setopt prompt_subst

  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{green}%M%f'
  fi

  PS1='%F{120}[%f%F{255}%K{236}%c%k%f%F{120}]%f '

  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^f' autosuggest-accept
