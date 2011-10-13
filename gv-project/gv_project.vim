" ==========================
" cscope configuration
" ==========================
"
let g:prj_name = ''
let g:ctags_file = ''
let g:cscope_db = ''
let g:src_dir = ''
let g:gv_dir = ''
let g:conf_dir = ''
let g:prj_conf_filename = ''
let g:prj_debug = 1

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


function! GV_ProjectInfo()
    echo g:prj_name
    echo g:ctags_file
    echo g:cscope_db
    echo g:src_dir
    echo g:conf_dir
endfunction

" ==========================
" Load python file
" ==========================
"pyfile D:/git/vim-setting/gv-project/gv_project.py

" ========================
" Test area
" ========================

"py gv_load("D:/git/vim-setting/gv-project/prj.conf")
"py gv_load()
"py gv_init()
"call GV_ProjectInfo()
"py gv_gencsope()
"py gv_gentags()
"py gv_settags()

" ========================
" Key mapping
" ========================
