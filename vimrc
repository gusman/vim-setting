" =============================================================================
" Common configuration
" =============================================================================
" Set language menu, none = always use english "
set langmenu=none

" Don't use local version of .(g)vimrc, .exrc
" set noexrc

" Set ruler
set ruler

" Show line number
set number

" Show title in console bar
set title

" Show the command being typed
set showcmd

" Show matching brackets
set showmatch

" Kill the beeps! (visible bell)
" set vb t_vb=

" No error bells (no beep, no blinking screen)
set noerrorbells

" Set mouse support in console
set mouse=a

" Set keep window's size (no resizing)
set noea

" Since I use linux, I want this
let g:clipbrdDefaultReg='+'

" Always display status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set laststatus=2  " Always show status line

" Backup
set backup
set backupdir=$HOME/.vimdata/backup
set directory=$HOME/.vimdata/swap

" Use scrollable menu for filename completion
set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                     \*.jpg,*.gif,*.png

" Turn on wild mode huge list
set wildmode=list:longest

" File format setting
set fileformats=unix,dos,mac

" =============================================================================
" Editing
" =============================================================================
"set ai                          "autoindent
"set si                          "smartindent
set backspace=indent,eol,start  "backspace behaviour
syntax on                       "enable syntax color
set hlsearch                    "higlight search resut
set wrapscan                    "searching whole file
set ic                          "ignore case sensitive
"set cindent                     "set cindent (c language indentation)

" =============================================================================
"  Tab and space configuration
" =============================================================================
" -- Configuration for specific editing 
function! DefaultEditor()
    set ts=4
    set sw=4
    set softtabstop=4
    set wrap
    set linebreak
    set expandtab
endfunction

function! Tab4Editor()
    setlocal ts=4
    setlocal sw=4
    setlocal softtabstop=4
    setlocal nowrap
    setlocal nolinebreak
    setlocal noexpandtab
endfunction

" Set default tab value
call DefaultEditor()


" =============================================================================
" Autocommand section
" ================================================================
" Only do this part when compiled with support for autocommands.
" By default autocommand is active
if has("autocmd")
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    " autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
    \if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \endif
    augroup END

    " auto command for specific file which has no handler
    autocmd FileType java   call Tab4Editor()
else
    set autoindent " always set autoindenting on
endif " has("autocmd")


" =============================================================================
" GUI Vim
" =============================================================================
" Remove all menu setting
set guioptions-=M
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Font setting
if has("gui_running")
    " Remove Gui Toolbar, it's useless
    set guioptions-=T

    " Set line and column number
    " set lines=44 columns=120

    " Font selection
    if has("gui_gtk3")
        set guifont=Inconsolata\ 12
    elseif has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_photon")
        set guifont=Courier\ New:s11
    elseif has("gui_kde")
        set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
    elseif has("x11")
        set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
    else
        set guifont=Fira\ Code\ Retina:h10
    endif
endif

" =============================================================================
" Common mapping
" =============================================================================
" Search hilight turn off key
nnoremap <silent> <S-h>     :nohlsearch<CR>
" toggle paste in insert on/off
set pastetoggle=<F2>


" =============================================================================
" Vim-Plug setting
" =============================================================================
call plug#begin()

"------ Global Editing Plug -------------------------------------------------
"Plug 'L9'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'AndrewRadev/simple_bookmarks.vim'
Plug 'Yggdroot/indentLine'
"Plug 'airblade/vim-rooter'


"------ Color Theme Plug -------------------------------------------------------
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
"------ C Coding Plug -------------------------------------------------------
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"------ C Coding Plug -------------------------------------------------------
"Plug 'chazy/cscope_maps'
"Plug 'vim-scripts/OmniCppComplete'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'gusman/vim-setting'

"------ Java Coding Plug ----------------------------------------------------
" Plug 'artur-shaik/vim-javacomplete2'

"------ Python Coding Plug --------------------------------------------------
"Plug 'davidhalter/jedi-vim'

"------ Latex Coding Plug ---------------------------------------------------
"Plug 'lervag/vimtex'

"------ Go Coding Plug ---------------------------------------------------
"Plug 'fatih/vim-go'

"------ Syntax ----------------------------------------------------------------
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

"------ Auto completion ------------------------------------------------------
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" =============================================================================
" NERD Tree key mapping and configuration
" =============================================================================
nnoremap <silent> <F9>      :NERDTreeToggle<CR>

" Quite when enter file "
let NERDTreeQuitOnOpen = 1
" Show bookmarks "
"let NERDTreeShowBookmars = 1
" Set win pos at right"
let NERDTreeWinPos = "right"
" Don't use fancy arrow to avoid garbage display
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" =============================================================================
" PATH configuration for windows only
" =============================================================================
if has('win32')
    let $PATH .=  ';' . $HOME . '\vimfiles\plugged\vim-setting\bin\'
endif

" =============================================================================
" cscope configuration
" =============================================================================
if has("cscope")
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

" =============================================================================
" CTRLP configuration
" =============================================================================
" Just search filename
let g:ctrlp_by_filename = 1

" Use regex for searching
let g:ctrlp_regexp = 1

" No scan for dotfiles or dotfolder
let g:ctrlp_dotfiles = 0

" No limit of number scanned files
let g:ctrlp_max_files = 50000

" Follow symlinks
let g:ctrlp_follow_symlinks = 1

" Lazy update, update list after 100s
let g:ctrlp_lazy_update = 100

let g:ctrlp_max_height = 25

let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*.so,*.swp,*.zip,*.JPEG,*.jpeg,*.JPG,*.JPEG,*.PNG,*.png

" =============================================================================
" Tagbar
" =============================================================================
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_iconchars = ['+', '-']
nnoremap <silent> <F8>      :TagbarToggle<CR>

" =============================================================================
" Simple bookmark
" =============================================================================
nnoremap <silent> <leader>b      :CopenBookmarks<CR>

" =============================================================================
" Colorscheme
" =============================================================================
colorscheme gruvbox
set bg=dark

" =============================================================================
" Cursor Line Hilight
" =============================================================================
" set cursorline
" hi cursoreline cterm=bold term=bold
" autocmd WinEnter * setlocal cursorline
" autocmd WinLeave * setlocal nocursorline
" if g:colors_name == "solarized"
"    highlight CursorLine guibg=#073642 ctermbg=0
" endif

" =============================================================================
" Indent Line
" =============================================================================
if g:colors_name == "solarized"
    if has("gui_running")
        highlight SpecialKey guibg=bg 
    else
        highlight SpecialKey ctermbg=bg
    endif
endif

let s:gIndent = 0
let g:indentLine_enabled = 0
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_setConceal = 1

function! IndentEnable()
    let s:gIndent = 1
    let g:indentLine_showFirstIndentLevel = 1
    set list listchars=tab:\|\ ,trail:·,extends:»,precedes:«
    IndentLinesEnable
endfunction

function! IndentDisable()
    let s:gIndent = 0
    let g:indentLine_showFirstIndentLevel = 0
    IndentLinesDisable
    set listchars=tab:\ \ ,trail:\ ,eol:\ ,nbsp:\ 
endfunction

function! IndentToogle()
    if 0 == s:gIndent
        call IndentEnable()
    else
        call IndentDisable()
    endif
endfunction

" Do not enable Indent by default
nnoremap <silent> <F3>      :call IndentToogle()<CR>

" =============================================================================
" VIM TEX
" =============================================================================
" execute vim --servername VIM
let g:vimtex_latexmk_build_dir = 'build'
let g:tex_conceal = ''

" =============================================================================
" Vim Grep
" =============================================================================
nnoremap <leader>g :Grepper -tool ag -cword -noprompt<cr>
nnoremap <leader>G :Grepper -git ag -cword -noprompt<cr>

" =============================================================================
" Vim Gutentags
" =============================================================================
let g:gutentags_cache_dir = $HOME . '/.vimdata/ctags'


" =============================================================================
" VIM Syntastic
" =============================================================================
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" =============================================================================
" VIM JEDI
" =============================================================================
" TODO: Need to find out how to enable below option
" let g:jedi#auto_initialization = 0

" =============================================================================
" My VIM Setting configuration
" =============================================================================
" C and CPP Editor
let g:c_cpp_editor = 1
let g:project_mode = 1

" Python Editor
let g:py_editor = 1

" Tex Editor
let g:tex_editor = 1

" Go Edit
let g:go_editor = 1
