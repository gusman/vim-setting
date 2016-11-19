"===================================================================
" Common configuration
"===================================================================
" User name
let g:usr_name="Gusman Dharma Putra"

" Use vim setting rather than vi setting
set nocompatible

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
" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
" set laststatus=2  " Always show status line

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

" Show line on column 80
if version >= 703
	set colorcolumn=80
endif

" File format setting
set fileformats=unix,dos,mac

" ================================================================
" Editing
" ================================================================
"set ai                          "autoindent
"set si                          "smartindent
set backspace=indent,eol,start  "backspace behaviour
syntax on                       "enable syntax color
set hlsearch                    "higlight search resut
set nowrap                      "nowrapping text
set wrapscan                    "searching whole file
set ic                          "ignore case sensitive
"set cindent                     "set cindent (c language indentation)

" Set default tab value

"set textwidth=79
set noexpandtab

" -- Configuration for specific editing 
"  =====================================================================
"  Tab and space configuration
"  =====================================================================
function! DefaultEditor()
	setlocal ts=4
	setlocal sw=4
	setlocal softtabstop=4
	setlocal nowrap
	setlocal linebreak
	setlocal noexpandtab
endfunction

function! Tab4Editor()
	setlocal ts=4
	setlocal sw=4
	setlocal softtabstop=4
	setlocal nowrap
	setlocal nolinebreak
	setlocal noexpandtab
endfunction

function! PyEditor()
	setlocal ts=4
	setlocal sw=4
	setlocal softtabstop=4
	setlocal autoindent
	setlocal expandtab
	setlocal fileformat=unix
endfunction

function! TexEditor()
	setlocal ts=4
	setlocal sw=4
	setlocal softtabstop=4
	setlocal autoindent
	setlocal expandtab
	setlocal fileformat=unix
endfunction


" Set default tab value
call DefaultEditor()


" ================================================================
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
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
	augroup END

	" auto command for c file 
	autocmd FileType python  call PyEditor()
	autocmd FileType java	 call Tab4Editor()
	autocmd FileType vim     call Tab4Editor()	
	autocmd FileType tex     call TexEditor()	

else
	set autoindent " always set autoindenting on
endif " has("autocmd")


" ================================================================
" GUI Vim
" ================================================================
if has("gui_running")
	" Remove Gui Toolbar, it's useless
	set guioptions-=T

	" Set line and column number
	" set lines=44 columns=120

	" Font selection
	if has("gui_gtk3")
		set guifont=hack\ 9 
	elseif has("gui_gtk2")
		set guifont=hack\ 9 
	elseif has("gui_photon")
		set guifont=Courier\ New:s11
	elseif has("gui_kde")
		set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
	elseif has("x11")
		set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
	else
		set guifont=hack:h9:cDEFAULT
	endif
endif

" ================================================================
" Common mapping
" ================================================================
" Search hilight turn off key
nnoremap <silent> <S-h>     :nohlsearch<CR>
" toggle paste in insert on/off
set pastetoggle=<F2>


" ================================================================
" Tab pages mapping
" ================================================================
" Insted of using below command please use original
" gt : Next tab, gT : prev tab, igt : index tab
" Tab new
" nmap <silent> <S-t>     :tabnew<CR>
" Tab next
" nmap <silent> <S-right> :tabn<CR>
" Tab previous
" nmap <silent> <S-left>  :tabp<CR>
" Tab close
" nmap <silent> <S-q>     :tabc<CR>


" ================================================================
" Vundle setting
" ===============================================================
filetype off		" mandatory

" setup
if has('win32')
	set rtp+=$HOME/vimfiles/bundle/Vundle.vim
	call vundle#begin('$HOME/vimfiles/bundle/')
else
	set rtp+=$HOME/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

"------ Global Editing Plugin -----------------------------------
Plugin 'L9'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/grep.vim'
Plugin 'AndrewRadev/simple_bookmarks.vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'powerline/powerline'

"------ C Coding Plugin -----------------------------------------
Plugin 'chazy/cscope_maps'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'gusman/vim-setting'

"------ Python Coding Plugin ------------------------------------
Plugin 'davidhalter/jedi-vim'

"------ Latex Coding Plugin -------------------------------------
Plugin 'lervag/vimtex'


call vundle#end()			" mandatory
filetype plugin indent on	" mandatory

" ================================================================
" NERD Tree key mapping and configuration
" ================================================================
nnoremap <silent> <F9>	:NERDTreeToggle<CR>

" Quite when enter file "
let NERDTreeQuitOnOpen = 1
" Show bookmarks "
"let NERDTreeShowBookmars = 1
" Set win pos at right"
let NERDTreeWinPos = "right"
" Don't use fancy arrow to avoid garbage display
let g:NERDTreeDirArrows=0

" ===============================================================
" Latex Suite Configuration
" ===============================================================
" dvi output previewer
" let g:Tex_ViewRule_dvi = 'xdvi'

" ps output previewer
" let g:Tex_ViewRule_ps  = 'evince'

" pdf output previewer
" let g:Tex_ViewRule_pdf = 'evince'	

" default output (if not set, default is dvi)
" let g:Tex_DefaultTargetFormat = 'pdf'

" ==============================================================
" PATH configuration for windows only
" ==============================================================
if has('win32')
	let $PATH .=  ';' . $HOME . '\vimfiles\bundle\vim-setting\bin\'
endif

" ==========================
" cscope configuration
" ==========================

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

" ==============================================================
" CTRLP configuration
" ==============================================================
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

" =======================================
" Grep
" =======================================
let Grep_Skip_Files = '*.bak *~' 
let Grep_Skip_Dirs = './.*'
nnoremap <silent> <leader>g :Grep<CR>


" =======================================
" Tagbar
" =======================================
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_iconchars = ['+', '-']
nnoremap <silent> <F8>      :TagbarToggle<CR>

" =======================================
" Simple bookmark
" =======================================
nnoremap <silent> <leader>b      :CopenBookmarks<CR>

" =======================================
" Colorscheme
" =======================================
set background=dark
if has("gui_running")
	colorscheme solarized
endif

" =======================================
" VIM TEX 
" ======================================
" execute vim --servername VIM
let g:vimtex_latexmk_build_dir = 'build'
"
" =======================================
" VIM JEDI
" ======================================
" TODO: Need to find out how to enable below option
" let g:jedi#auto_initialization = 0


" =============================================================================
" My VIM Setting configuration
" =============================================================================
let g:c_cpp_editor = 1
let g:project_mode = 1
