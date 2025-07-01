#. "/usr/share/git/completion/git-prompt.sh"
## include .bashrc if it exists
#if [ -f "$HOME/ConfigRepo/.bashrc" ]; then
#  . "$HOME/ConfigRepo/.bashrc"
#else
#  echo 'error importing base config'
#fi

#zoxide fun
#eval "$(zoxide init --cmd cd bash)"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


HISTCONTROL=ignoreboth # ignore duplicates and commands starting with space
shopt -s histappend # append to history file
HISTSIZE=1000 #history length
HISTFILESIZE=2000 #history size

shopt -s checkwinsize # check window size after each command
set -o vi #vi mode in console
export LC_COLLATE="C" #Upper case names before lower case with ls
bind 'set completion-ignore-case on'

#Maybe move these into an alias file like suggested by the original bashrc
alias ls='ls -Fp --color=auto --show-control-chars --group-directories-first'
alias lsl='ls -lh'
alias lsa='ls -A'
alias cdr='cd $(git root)'
alias cdd='cd $(find . -type d | cut -c 3- | fzf)'
alias c='clear -x'
alias grep='grep --color=auto'
#alias alert='pwsh -Command '\''[console]::beep(500,1000)'\'

# this option might be windows specific, copy as needed I guess... wait why the hell is it sv_SE... later...
# export LC_ALL=sv_SE.utf8 #fix only part of character being deleted
# or use -il as arguments for bash when using it in terminal or other programs... (works for windows terminal, but not for Wezterm)

# set vim as editor
export VISUAL=vim
export EDITOR="$VISUAL"

PS1='\n\[\e[35m\]\t\[\e[0m\] \[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\[\e[36m\]`__git_ps1`\n\[\e[0m\]\\$ '


#alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
