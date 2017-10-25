" ================================================================
" Tab and spaces configuration
" ================================================================
function! Go_TabSpaces()
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
function! Go_KeyMapping()

endfunction

" ================================================================
" Global Configuration Setting Update
" ================================================================
function! Go_GlobalPluginReConfigure()

endfunction

" ================================================================
" Setup
" ================================================================
function! Go_EditorSetup()
    "Entering GO EDITOR
    call Go_TabSpaces()
    call Go_GlobalPluginReConfigure()
    call Go_KeyMapping()
endfunction

" ================================================================
" Global control
" ================================================================
if (1 == g:go_editor)
    if has("autocmd")
        autocmd FileType go call Go_EditorSetup()
    endif
endif
