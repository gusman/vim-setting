" =============================================================================
" Global variable
" =============================================================================
let s:py_script_loaded = 0

" =============================================================================
" Function list related to python execution
" =============================================================================
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

" =============================================================================
" Key mapping
" =============================================================================
" <F8> : already used in vimrc for tagbar toggle
" <F9> : already used in vimrc for NERDTree toggle
function! GV_KeyMappingCommon()
	if (1 == g:project_mode)
		nmap <F10> : call GV_Load()<CR> 
		nmap <F11> : call GV_GenCtags()<CR>
		nmap <F12> : call GV_GenCscope() <CR>
	endif
endfunction

" =============================================================================
" Load python file
" =============================================================================
function! GV_LoadPython()
	if 0 == s:py_script_loaded && 1 == g:project_mode
		if has('win32')
			if has('python3')
				py3file $HOME/vimfiles/bundle/vim-setting/plugin/c_prj_hndlr.py
			else
				pyfile $HOME/vimfiles/bundle/vim-setting/plugin/c_prj_hndlr.py
			endif
		else
			if has('python3')
				py3file $HOME/.vim/bundle/vim-setting/plugin/c_prj_hndlr.py
			else 
				pyfile $HOME/.vim/bundle/vim-setting/plugin/c_prj_hndlr.py
			endif
		endif
	endif
endfunction

" =============================================================================
" Tab and space configuration
" =============================================================================
function! GV_C_CppEditor()
	setlocal ts=8
	setlocal sw=8
	setlocal softtabstop=8
	setlocal nowrap
	setlocal nolinebreak
	setlocal noexpandtab
endfunction

" =============================================================================
" Reconfigure GREP plugin and CTRL-P plugin
" =============================================================================
function! GV_GlobalPluginReConfigure()
	" Grep config changes
	let Grep_Default_Options = '-nri --include="*.[chS]" --include="*.cpp" --include="*.CPP" --include="*.hpp" --include="*.HPP"' 

	" Grep config update
	if has("win32") && (1 == g:project_mode)
		let g:ctrlp_user_command = 'type %s\.gvproj\project.files'
	else
		let g:ctrlp_user_command = 'cat %s/.gvproj/project.files'
	endif
endfunction

" =============================================================================
" Event driven action
" =============================================================================
function! GV_AutoCmd()
	if has("autocmd") && 1 == g:project_mode
		" Is filetype auto sensitive
		autocmd BufWritePost *.[chCH]	: call GV_AddUpdate() " C files
		autocmd BufWritePost *.[ch]pp	: call GV_AddUpdate() " cpp files lower case
		autocmd BufWritePost *.[CH]PP	: call GV_AddUpdate() " cpp files upper case
	endif
endfunction

" =============================================================================
" Wrap it all
" =============================================================================
function! C_CppEditorSetup()
	"echo "ENTERING C / CPP EDITOR"
	call GV_C_CppEditor()
	call GV_GlobalPluginReConfigure()
	call GV_LoadPython()
	call GV_KeyMappingCommon()
	call GV_AutoCmd()
endfunction

" =============================================================================
" Global variable trigger
" =============================================================================
if (1 == g:c_cpp_editor)
	if has("autocmd")
		autocmd FileType c,cpp,h call C_CppEditorSetup()
	endif
endif
