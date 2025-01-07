## include .bashrc if it exists
#if [ -f "$HOME/ConfigRepo/.bashrc" ]; then
#  . "$HOME/ConfigRepo/.bashrc"
#else
#  echo 'error importing base config'
#fi

set -o vi #vi mode in console

export LC_COLLATE="C" #Upper case names before lower case with ls
alias ls='ls -Fp --color=auto --show-control-chars --group-directories-first'
alias cdr='cd $(git root)'
alias c='clear -x'
#alias alert='pwsh -Command '\''[console]::beep(500,1000)'\'

# this option might be windows specific, copy as needed I guess... wait why the hell is it sv_SE... later...
# export LC_ALL=sv_SE.utf8 #fix only part of character being deleted
# or use -il as arguments for bash when using it in terminal or other programs... (works for windows terminal, but not for Wezterm)

# set vim as editor
export VISUAL=vim
export EDITOR="$VISUAL"

#PS1 from windows git bash
#\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$
