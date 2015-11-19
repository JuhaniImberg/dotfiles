# General settings
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_BEEP
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt DVORAK
setopt INTERACTIVE_COMMENTS
setopt PRINT_EXIT_VALUE
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
zstyle ':vcs_info:*' stagedstr ' S'
zstyle ':vcs_info:*' unstagedstr ' U'
zstyle ':vcs_info:*' formats '(%b%u%c) '
zstyle ':vcs_info:*' actionformats '(%b %a%u%c) '

precmd () { vcs_info }

PS1='%~ ${vcs_info_msg_0_}%f%# '
