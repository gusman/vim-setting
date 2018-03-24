" =============================================================================
" Tab and space configuration
" =============================================================================
function! C_CppEditor()
    setlocal ts=8
    setlocal sw=8
    setlocal softtabstop=8
    setlocal nowrap
    setlocal nolinebreak
    setlocal noexpandtab
endfunction

" =============================================================================
" Wrap it all
" =============================================================================
function! C_CppEditorSetup()
    "echo "ENTERING C / CPP EDITOR"
    call C_CppEditor()
endfunction

" =============================================================================
" Global variable trigger
" =============================================================================
if (1 == g:c_cpp_editor)
    if has("autocmd")
        autocmd FileType c,cpp,h call C_CppEditorSetup()
    endif
endif
