" ================================================================
" Tab and spaces configuration
" ================================================================
function! Py_TabSpaces()
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
function! Py_KeyMapping()

endfunction

" ================================================================
" Global Configuration Setting Update
" ================================================================
function! Py_GlobalPluginReConfigure()
    " Grep config changes
    let Grep_Default_Options = '-nri --include="*.py" --include="*.python"'
endfunction

" ================================================================
" Setup
" ================================================================
function! Py_EditorSetup()
    "Entering PYTHON EDITOR
    call Py_TabSpaces()
    call Py_GlobalPluginReConfigure()
    call Py_KeyMapping()
endfunction

" ================================================================
" Global control
" ================================================================
if (1 == g:py_editor)
    if has("autocmd") 
        autocmd FileType python call Py_EditorSetup()
    endif
endif
