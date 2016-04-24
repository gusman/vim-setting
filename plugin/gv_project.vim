"================================="
" Global variable
" ================================"

" ==========================
" Load python file
" ==========================
if has('win32')
	if has('python3')
		py3file $HOME/vimfiles/bundle/vim-setting/plugin/gv_project.py
	else
		pyfile $HOME/vimfiles/bundle/vim-setting/plugin/gv_project.py
	endif
else
	if has('python3')
		py3file $HOME/.vim/bundle/vim-setting/plugin/gv_project.py
	else 
		pyfile $HOME/.vim/bundle/vim-setting/plugin/gv_project.py
	endif
endif

" ===================================
" Function list
" ===================================
function! GV_ProjectInfo()
    echo "will define"
endfunction

function! GV_Init()
	if has('python3')
		py3 gv_init()
	else
		py gv_init()
	endif
endfunction

function! GV_Load()
	if has('python3')
		py3 gv_load()
	else
		py gv_load()
	endif
endfunction

function! GV_GenCscope()
	if has('python3')
		py3 gv_gencscope()
	else
		py gv_gencscope()
	endif
    cs reset
endfunction

function! GV_GenCtags()
	if has('python3')
		py3 gv_gentags()
	else
		py gv_gentags()
	endif
endfunction

function! GV_AddUpdate()
	if has('python3')
		py3 gv_add_task()
	else
		py gv_add_task()
	endif
endfunction


" ========================
" Key mapping
" ========================

" <F8> : already used in vimrc for tagbar toggle
" <F9> : already used in vimrc for NERDTree toggle
function! GV_KeyMappingCommon()
    nmap <F10> : call GV_Load()<CR> 
    nmap <F11> : call GV_GenCtags()<CR>
    nmap <F12> : call GV_GenCscope() <CR>
endfunction

function! GV_KeyMappingJava()
"For smart (trying to guess import option) insert class import with <F4>:
    nmap <F10> <Plug>(JavaComplete-Imports-AddSmart)
    imap <F10> <Plug>(JavaComplete-Imports-AddSmart)

"For usual (will ask for import option) insert class import with <F5>:
    "nmap <F5> <Plug>(JavaComplete-Imports-Add)
    "imap <F5> <Plug>(JavaComplete-Imports-Add)

"For add all missing imports with <F6>:
    nmap <F11> <Plug>(JavaComplete-Imports-AddMissing)
    imap <F11> <Plug>(JavaComplete-Imports-AddMissing)

"For remove all missing imports with <F7>:
    nmap <F12> <Plug>(JavaComplete-Imports-RemoveUnused)
    imap <F12> <Plug>(JavaComplete-Imports-RemoveUnused)

endfunction

" =======================
" Event driven action
" =======================
if has("autocmd")
    " Is filetype auto sensitive
    autocmd BufWritePost *.[chCH]	: call GV_AddUpdate() " C files
    autocmd BufWritePost *.[ch]pp	: call GV_AddUpdate() " cpp files lower case
    autocmd BufWritePost *.[CH]PP	: call GV_AddUpdate() " cpp files upper case
endif
    

