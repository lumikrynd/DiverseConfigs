## include .bashrc if it exists
#if [ -f "$HOME/ConfigRepo/.bashrc" ]; then
#    . "$HOME/ConfigRepo/.bashrc"
#fi

set -o vi #vi mode in console

alias ls='ls -F --color=auto --show-control-chars --group-directories-first'
alias cdr='cd $(git root)'
alias c='clear -x'
#alias alert='pwsh -Command '\''[console]::beep(500,1000)'\'

export LC_ALL=sv_SE.utf8 #fix only part of character being deleted
# or use -il as arguments for bash when using it in terminal or other programs... (works for windows terminal, but not for Wezterm)
