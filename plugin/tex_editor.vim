" ================================================================
" Tab and spaces configuration
" ================================================================
function! Tex_TabSpaces()
	setlocal ts=4
	setlocal sw=4
	setlocal softtabstop=4
	setlocal autoindent
	setlocal expandtab
	setlocal fileformat=unix
endfunction

" ================================================================
" Key Map
" ================================================================
function! Tex_KeyMapping()

endfunction

" ================================================================
" Global Configuration Setting Update
" ================================================================
function! Tex_GlobalPluginReConfigure()
	" Grep config changes
	let Grep_Default_Options = '-nri --include="*.tex"'
endfunction

" ================================================================
" Setup
" ================================================================
function! Tex_EditorSetup()
	"Entering TEX EDITOR
	call Tex_TabSpaces()
	call Tex_GlobalPluginReConfigure()
	call Tex_KeyMapping()
endfunction

" ================================================================
" Global control
" ================================================================
if (1 == g:tex_editor)
	if has("autocmd")
		autocmd FileType texthon call Tex_EditorSetup()
	endif
endif
