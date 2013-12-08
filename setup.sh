#!/bin/sh

# Install vundle
PWD=`pwd`
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && cp $PWD/vimrc ~/.vimrc

