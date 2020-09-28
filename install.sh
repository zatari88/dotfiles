#!/bin/sh

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

base16_tomorrow-night

