## include .bashrc if it exists
#if [ -f "$HOME/ConfigRepo/.bashrc" ]; then
#    . "$HOME/ConfigRepo/.bashrc"
#fi

set -o vi #vi mode in console

alias ls='ls -F --color=auto --show-control-chars --group-directories-first'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias c='clear'

