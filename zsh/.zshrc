# General settings
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_BEEP
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt DVORAK
setopt INTERACTIVE_COMMENTS
setopt EMACS
setopt PROMPT_SUBST

export HISTFILE=$HOME/.zsh_history
export SAVEHIST=30000
export HISTSIZE=30000
export PATH=$PATH:$HOME/bin
export EDITOR=nano

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

zstyle ':completion:*' menu select

# Keybinds
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey '^[[2~' overwrite-mode

# Aliases
alias gst='git status'
alias ga='git add'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gc='git commit'
alias glo="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gsh='git show'

alias ls='ls --color'
alias l='ls -alh'

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{2}S%f'
zstyle ':vcs_info:*' unstagedstr ' %F{1}U%f'
zstyle ':vcs_info:*' formats ' %s:(%b%c%u)'
zstyle ':vcs_info:*' actionformats ' %s:(%b %a%c%u)'

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
hash virtualenvwrapper.sh 2>/dev/null && source virtualenvwrapper.sh

vew_info () {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        typeset -g vew_info_msg=''
    else
        typeset -g vew_info_msg=" venv:(${VIRTUAL_ENV##*/})"
    fi
}

# chicken

export CHICKEN_REPOSITORY=~/eggs/lib/chicken/7
mkdir -p $CHICKEN_REPOSITORY

# go

export GOPATH=~/go
mkdir -p $GOPATH
export PATH=$PATH:$GOPATH/bin

# nvm

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Prompt

precmd () {
    vcs_info
    vew_info
    typeset -g info_msg=""
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        typeset -g info_msg="%n@%M "
    fi
    dircol=2
    if [[ "$USER" = "root" ]]; then
        dircol=1
    fi
    info_msg="${info_msg}%F{${dircol}}%~%f"
}

PS1='${info_msg}${vew_info_msg}${vcs_info_msg_0_} %# '
