" =============================================================
" My Script Properties
" =============================================================
let g:gv_srcdir = '/home/gusman/zoran'
let g:gv_projdir = ''
let g:gv_projfile = ''
let g:gv_tagsfile = ''
let g:gv_macrolist = ''

" =============================================================
" My Grep script 
" =============================================================
function! GV_GrepUnderCursor()
        let s:curr_word = expand("<cword>")
        exec 'cd ' . g:gv_srcdir
        exec 'vimgrep /' . s:curr_word . '/gj ./**/*.c ./**/*.h'
        exec 'cw'
endfunction

nnoremap <silent> <F2> :call GV_GrepUnderCursor() <CR>

" ============================================================
" Fuzzy finder map
" ============================================================
" Find file
nnoremap <silent> <F3> :FufFile <CR>

" === resource vimrc
nnoremap <silent> <LocalLeader>s :source $MYVIMRC <CR>

" ============================================================
" Application function
" ============================================================

" Load function in python module
pyfile $HOME/.vim/plugin/gv-project.py

" To input Project Dir
function! GV_InputSrcDir()
        call inputsave()
        let g:gv_srcdir = inputdialog('Source Directory: ')
        call inputrestore()
endfunction


" Show Project Properties
function! GV_ShowProperties()
        echo g:gv_srcdir
        echo g:gv_projdir
        echo g:gv_projfile
        echo g:gv_tagsfile
        echo g:gv_macrolist
endfunction

function! GV_Init()
        py create_projdir()
        py create_projfile()
        py create_macrolistfile()

        " Update some plugins global variable value
        let g:ifdef_filename = g:gv_macrolist

        " Go to source directory
        exec 'cd ' . g:gv_srcdir
endfunction

nnoremap <silent> <F4> :call GV_Init() <CR>

