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
alias {ll,la}='ls -lah'

alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

# alias v and vi to vim
alias {v,vi}='vim'
alias {vr,vir,vimr}='vim -R' # -R = readonly

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

# Stow aliases
alias unstow='stow --delete'
alias restow='stow --restow' #unstow followed by stow. Used to prune old symlinks

findFile() {
    if [[ $1 == '' ]] || [[ $2 == '' ]]; then
        echo 'Useage: findFile <path> <iname>'
    else
        # 2>&1 pushes stderr through stdout then grep -v removes messages with
        # 'Permission denied' in the text
        find $1 -iname $2 2>&1 | grep -v "Permission denied"
    fi
}

findFileExact() {
    if [[ $1 == '' ]] || [[ $2 == '' ]]; then
        echo 'Useage: findFile <path> <name>'
    else
        find $1 -name $2 2>&1 | grep -v "Permission denied"
    fi
}

fixWSL2ResolutionErrors() {
    printf "\n[network]\ngenerateResolvConf=false\n" | sudo tee -a /etc/wsl.conf
    printf "nameserver 8.8.8.8\n" | sudo tee -a /etc/resolv.conf
}
