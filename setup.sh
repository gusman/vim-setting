#!/bin/sh

# Install vundle
PWD=$HOME/.vim/bundle/vim-setting
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
ln -sf $PWD/vimrc ~/.vimrc \
    && mkdir -p ~/.vimdata/swap \
    && mkdir -p ~/.vimdata/backup \
    && mkdir -p ~/.vimdata/ctags

