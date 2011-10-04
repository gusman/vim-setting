" ===========================
" gv_project global variabel
" ===========================
let g:prj_name = 'gv-python'
let g:ctags_file = ''
let g:cscope_file = ''
let g:src_dir = 'D:\git\vim-setting\gv-project'
let g:gv_dir = $HOME . '\.gvproj'
let g:conf_dir = ''
let g:prj_conf_filename = ''
let g:prj_debug = 1

" ==========================
" cscope configuration
" ==========================
if has("cscope")
    set csprg=C:\mingw\bin\cscope.exe
    set csto=0
    set cst
    set nocsverb

    "example for cscope scritp
    " add any database in current directory
    " if filereadable("cscope.out")
    "    cs add cscope.out
    " else add database pointed to by environment
    " elseif $CSCOPE_DB != ""
    "    cs add $CSCOPE_DB
    " endif
    set csverb
endif



" ==========================
" Load python file
" ==========================
pyfile D:/git/vim-setting/gv-project/gv_project.py

" =========================
" Function list
" =========================
function! GV_ProjectInfo()
    echo g:prj_name
    echo g:ctags_file
    echo g:cscope_file
    echo g:src_dir
    echo g:conf_dir
endfunction


" ========================
" Test area
" ========================
py gv_init()
py gv_gentags()
py gv_settags()

" ========================
" Key mapping
" ========================