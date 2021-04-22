#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"

# Default to human readale figures
alias df='df -h'
alias du='du -h'

# Grep with color
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Directory listing shortcuts with color
alias ls='ls -hF --color=tty'
alias ll='ls -lah'
alias la='ls -lah'

alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

# alias v and vi to vim
alias v='vim'
alias vi='vim'

# Start Windows command prompt from cygwin
alias cmd='cmd /c start cmd'

# Delete all swap file in the current directory
alias rmswp='rm ./.*.swp'

# Change directory and list the files in it
cdl  () { cd $1; ls; }
cdla () { cd $1; la; }

# Make backing up directory tree easier
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias ............="cd ../../../../../../../../../../.."
alias .............="cd ../../../../../../../../../../../.."

