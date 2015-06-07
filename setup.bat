CD ../../../

IF NOT EXIST .vimdata\swap (
    ECHO "CREATING SWAP DIRECTORY"
    MKDIR .vimdata\swap
)

IF NOT EXIST .vimdata\backup (
    ECHO "CREATING BACKUP DIRECTORY"
    MKDIR .vimdata\backup
)

IF NOT EXIST .vim\bundle\vundle (
    ECHO "CLONING VUNDLE GIT"
    git clone https://github.com/gmarik/vundle.git .vim\bundle\vundle
)

COPY .vim\bundle\vim-setting\vimrc .vimrc
