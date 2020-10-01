#!/bin/bash

# clone base16-shell
git clone https://github.com/chriskempson/base16-shell.git ~/.dotfiles/config/.config/base16-shell

# clone base16-vim
git clone https://github.com/chriskempson/base16-vim.git ~/.dotfiles/vim/.vim/colors/base16-vim

# move the vim color files to the .vim color folder
cp ~/.dotfiles/vim/.vim/colors/base16-vim/colors/*.vim ~/.dotfiles/vim/.vim/colors

# use stow to create the symlinks
stow bash
stow config
#stow mintty
stow tmux
stow vim
stow git

if [[ "$OSTYPE" == "linux-gnu" && "$(uname -r)" == *"Microsoft" ]]; then
    git config --global core.autocrlf false
    git config --global core.filemode false
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    printf('gitconfig for Linux')
    git config --global core.autocrlf false
    git config --global core.filemode false
elif [[ "$OSTYPE" == "cygwin" ]]; then
    printf('gitconfig for Cygwin')
    git config --global core.autocrlf false
    git config --global core.autocrlf true
    git config --global core.filemode true
fi

base16_tomorrow-night

