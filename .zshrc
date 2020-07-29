## If you come from bash you might have to change your $PATH.
## export PATH=$HOME/bin:/usr/local/bin:$PATH

##
## Path to your oh-my-zsh installation.
# export ZSH="/home/machine/.oh-my-zsh"

## Set name of the theme to load --- if set to "random", it will
## load a random theme each time oh-my-zsh is loaded, in which case,
## to know which specific one was loaded, run: echo $RANDOM_THEME
## See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="gianu"

## Set list of themes to pick from when loading at random
## Setting this variable when ZSH_THEME=random will cause zsh to load
## a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
## If set to an empty array, this variable will have no effect.
## ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

## Uncomment the following line to use case-sensitive completion.
## CASE_SENSITIVE="true"

## Uncomment the following line to use hyphen-insensitive completion.
## Case-sensitive completion must be off. _ and - will be interchangeable.
## HYPHEN_INSENSITIVE="true"

## Uncomment the following line to disable bi-weekly auto-update checks.
## DISABLE_AUTO_UPDATE="true"

## Uncomment the following line to automatically update without prompting.
## DISABLE_UPDATE_PROMPT="true"

## Uncomment the following line to change how often to auto-update (in days).
## export UPDATE_ZSH_DAYS=13

## Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

## Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

## Uncomment the following line to disable auto-setting terminal title.
## DISABLE_AUTO_TITLE="true"

## Uncomment the following line to enable command auto-correction.
## ENABLE_CORRECTION="true"

## Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

## Uncomment the following line if you want to disable marking untracked files
## under VCS as dirty. This makes repository status check for large repositories
## much, much faster.
## DISABLE_UNTRACKED_FILES_DIRTY="true"

## Uncomment the following line if you want to change the command execution time
## stamp shown in the history command output.
## You can set one of the optional three formats:
## "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
## or set a custom format using the strftime function format specifications,
## see 'man strftime' for details.
# export HIST_STAMPS="mm/dd/yyyy"
export HISTFILE=$HOME/.zsh_history

## Would you like to use another custom folder than $ZSH/custom?
## ZSH_CUSTOM=/path/to/new-custom-folder

## Which plugins would you like to load?
## Standard plugins can be found in ~/.oh-my-zsh/plugins/*
## Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
## Example format: plugins=(rails git textmate ruby lighthouse)
## Add wisely, as too many plugins slow down shell startup.
# plugins=(
#     git
#     zsh-autosuggestions
#     history-substring-search
#     fzf
# )
# source $ZSH/oh-my-zsh.sh

## User configuration
export GOPATH=$HOME/dev/golang
export GOBIN=$GOPATH/bin
export EDITOR=/bin/nvim
export TERMINAL=/usr/local/bin/st
export BROWSER=brave
export READER=/usr/bin/zathura
export PATH=$PATH:$GOPATH:$GOBIN:$HOME/.local/bin/:$HOME/.cargo/bin:$HOME/.local/bin/i3blocks:$HOME/.local/bin/cron:$HOME/.yarn/bin/
source ~/.aliases

export TERM=xterm-color

# Fzf related
export FZF_DEFAULT_OPTS=""
export FZF_CTRL_T_OPTS='--bind alt-k:preview-up,alt-j:preview-down --height=70% --preview="ccat --color=always {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_COMMAND="rg --files --no-messages --no-ignore --no-ignore-vcs --hidden"
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_OPEN_COMMAND=$FZF_DEFAULT_COMMAND

export _JAVA_AWT_WM_NONREPARENTING=1
export WALLCMD="/usr/bin/xwallpaper --daemon --zoom "
export TERM=screen-256color

function fzf_open {
    eval "$FZF_OPEN_COMMAND |" fzf $FZF_CTRL_T_OPTS | xargs -r $EDITOR
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

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

autoload -Uz compinit
compinit
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
#
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ~/sector

PATH="/home/machine/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/machine/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/machine/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/machine/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/machine/perl5"; export PERL_MM_OPT;
