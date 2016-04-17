CD ../../../

IF NOT EXIST .vimdata\swap (
    ECHO "CREATING SWAP DIRECTORY"
    MKDIR .vimdata\swap
)

IF NOT EXIST .vimdata\backup (
    ECHO "CREATING BACKUP DIRECTORY"
    MKDIR .vimdata\backup
)

IF NOT EXIST vimfiles\bundle\vundle (
    ECHO "CLONING VUNDLE GIT"
    git clone https://github.com/VundleVim/Vundle.vim vimfiles\bundle\
)

COPY vimfiles\bundle\vim-setting\vimrc _vimrc
