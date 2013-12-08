"================================="
" Global variable
" ================================"


" ==========================
" Load python file
" ==========================
if has("win32")
    pyfile $HOME/vimfiles/bundle/gvproj/plugin/gv_project.py
else
    pyfile $HOME/.vim/bundle/gvproj/plugin/gv_project.py
endif

" ===================================
" Function list
" ===================================
function! GV_ProjectInfo()
    echo "will define"
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

" function! GV_FUFList()
"    call fuf#givenfile#launch('', 1, 'PRJ>', g:alist)
" endfunction


" ========================
" Key mapping
" ========================
" nmap <F6>  : FufRenewCache<CR>
" nmap <F7>  : call GV_FUFList()<CR> 
" <F8> : already used in vimrc for taglist toggle
" <F9> : already used in vimrc for NERDTree toggle
nmap <F10> : call GV_Load()<CR> 
nmap <F11> : call GV_GenCtags()<CR>
nmap <F12> : call GV_GenCscope() <CR>

