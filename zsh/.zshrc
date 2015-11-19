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

# Aliases
alias gst='git status'
alias ga='git add'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gc='git commit'
alias glo='git shortlog'
alias gsh='git show'

alias ls='ls --color'
alias l='ls -alh'

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{2}S%f'
zstyle ':vcs_info:*' unstagedstr ' %F{1}U%f'
zstyle ':vcs_info:*' formats '(%b%c%u) '
zstyle ':vcs_info:*' actionformats '(%b %a%c%u) '

precmd () { vcs_info }

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source virtualenvwrapper.sh

PS1='%~ ${vcs_info_msg_0_}%f%# '
