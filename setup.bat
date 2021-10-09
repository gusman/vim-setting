CD ../../../

IF NOT EXIST .vimdata\swap (
    ECHO "CREATING SWAP DIRECTORY"
    MKDIR .vimdata\swap
)

IF NOT EXIST .vimdata\backup (
    ECHO "CREATING BACKUP DIRECTORY"
    MKDIR .vimdata\backup
)

IF NOT EXIST .vimdata\ctags (
    ECHO "CREATING CTAGS CACHE DIRECTORY"
    MKDIR .vimdata\ctags
)

mklink _vimrc vimfiles\plugged\vim-setting\vimrc
