#!/bin/sh

PWD=$HOME/.vim/plugged/vim-setting
ln -sf $PWD/vimrc ~/.vimrc \
    && mkdir -p ~/.vimdata/swap \
    && mkdir -p ~/.vimdata/backup \
    && mkdir -p ~/.vimdata/ctags

