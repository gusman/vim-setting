"================================="
" Global variable
" ================================"
let g:c_ide_mode = 0

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
	let g:c_ide_mode = 1
	if has('python3')
		py3 gv_init()
	else
		py gv_init()
	endif
endfunction

function! GV_Load()
	let g:c_ide_mode = 1
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
	let g:c_ide_mode = 1
	call GV_CtrlPCommandSet()
	if has('python3')
		py3 gv_add_task()
	else
		py gv_add_task()
	endif
endfunction

function! GV_CtrlPCommandSet()
	" Custom list based on file list
	if (1 == g:c_ide_mode)
		let g:ctrlp_working_path_mode = 0
		if has("win32")
		    "let g:ctrlp_user_command = [getcwd().'/.gvproj/project.files', 'type %s/'.'/.gvproj/project.files']
		    let g:ctrlp_user_command = 'type %s\.gvproj\project.files'
		else
		    "let g:ctrlp_user_command = [getcwd().'/.gvproj/project.files', 'cat %s/'.'/.gvproj/project.files']
		    let g:ctrlp_user_command = 'cat %s/.gvproj/project.files'
		endif
	endif
endfunction

function! GV_CtrlPCommandClear()
	let g:ctrlp_working_path_mode = 1
	let g:ctrlp_user_command = ''
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

" =======================
" Event driven action
" =======================
if has("autocmd")
    " Is filetype auto sensitive
    autocmd BufWritePost *		: call GV_CtrlPCommandClear() " All files

    autocmd BufWritePost *.[chCH]	: call GV_AddUpdate() " C files
    autocmd BufWritePost *.[ch]pp	: call GV_AddUpdate() " cpp files lower case
    autocmd BufWritePost *.[CH]PP	: call GV_AddUpdate() " cpp files upper case
endif
    

