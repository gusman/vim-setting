#!/bin/sh

# Install vundle
PWD=$HOME/.vim/bundle/vim-setting
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 
ln -sf $PWD/vimrc ~/.vimrc && mkdir -p ~/.vimdata/swap && mkdir -p ~/.vimdata/backup

