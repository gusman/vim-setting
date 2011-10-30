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
" FUF abrev map
" ===================================
let g:fuf_abbrevMap = {
    \   '^prj:' : [ g:src_dir.'**/' ],
\}
" ===================================
" Function list
" ===================================
function! GV_ProjectInfo()
    echo g:prj_name
    echo g:ctags_file
    echo g:cscope_db
    echo g:src_dir
    echo g:conf_dir
endfunction

function! GV_Load()
    " using windows default ./gvproj/prj.conf doesn't work
    py gv_load()
endfunction

function! GV_GenCscope()
    py gv_gencscope()
endfunction

function! GV_GenCtags()
    py gv_gentags()
endfunction

" ========================
" Key mapping
" ========================
" Should no space after fuf abrev, in this case prj:
nmap <F7>  : FufFile prj:<CR> 
" <F8> : already used in vimrc for taglist toggle
" <F9> : already used in vimrc for NerdTree toggle
nmap <F10> : call GV_Load()<CR> 
nmap <F11> : call GV_GenCtags()<CR>
nmap <F12> : call GV_GenCscope( <CR>
