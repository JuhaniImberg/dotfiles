# General settings
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_BEEP
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt DVORAK
setopt INTERACTIVE_COMMENTS
setopt EMACS
setopt PROMPT_SUBST

export HISTFILE=$HOME/.zsh_history
export SAVEHIST=30000
export PATH=$PATH:$HOME/bin
export EDITOR=nano

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
source virtualenvwrapper.sh

vew_info () {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        typeset -g vew_info_msg=''
    else
        typeset -g vew_info_msg=" venv:(${VIRTUAL_ENV##*/})"
    fi
}

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
