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
let g:prj_debug = 0

if has("cscope")
    if has("win32")
	set csprg=C:\mingw\bin\cscope.exe
    else
	set csprg=/usr/bin/cscope
    endif
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
if has("win32")
    pyfile $HOME/vimfiles/bundle/gvproj/plugin/gv_project.py
else
    pyfile $HOME/.vim/bundle/gvproj/plugin/gv_project.py
endif

" ===================================
" FUF
" ===================================
let g:alist = []
let g:fuf_enumeratingLimit = 25
let g:fuf_maxMenuWidth = 78 " will be adjusted 

" ===================================
" Function list
" ===================================
function! GV_ProjectInfo()
    echo "PROJ NAME: " . g:prj_name
    echo "TAGS FILE: " . g:ctags_file
    echo "CSCOPE DB: " . g:cscope_db
    echo "SRC DIR: "   . g:src_dir
    echo "CONF DIR: "  . g:conf_dir
endfunction

function! GV_Init()
    py gv_init()
endfunction

function! GV_Load()
    py gv_load()
endfunction

function! GV_GenCscope()
    py gv_gencscope()
    cs reset
endfunction

function! GV_GenCtags()
    py gv_gentags()
endfunction

function! GV_FUFList()
    call fuf#givenfile#launch('', 1, 'PRJ>', g:alist)
endfunction

" ========================
" Key mapping
" ========================
nmap <F6>  : FufRenewCache<CR>
nmap <F7>  : call GV_FUFList()<CR> 
" <F8> : already used in vimrc for taglist toggle
" <F9> : already used in vimrc for NERDTree toggle
nmap <F10> : call GV_Load()<CR> 
nmap <F11> : call GV_GenCtags()<CR>
nmap <F12> : call GV_GenCscope() <CR>

