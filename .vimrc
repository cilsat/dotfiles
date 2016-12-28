" STARTUP
runtime! debian.vim
filetype off
syntax enable

" Open file from previous buffer position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" PLUGINS
set rtp+=~/.vim/bundle/Vundle.vim       " Add Vundle to runtime path and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required

" Functional
Plugin 'christoomey/vim-tmux-navigator' " Navigate between tmux/vim panes
Plugin 'scrooloose/nerdtree'            " File navigator
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'simnalamburt/vim-mundo'         " Vim undo tree graphical navigator
Plugin 'wellle/targets.vim'             " Expands text object actions/gestures
Plugin 'tpope/vim-repeat'               " Expands repeatable actions/gestures
Plugin 'tpope/vim-fugitive'             " Git wrapper for vim
Plugin 'vim-scripts/VisIncr'            " Expands autoincrement functions
Plugin 'Valloric/YouCompleteMe'         " Auto-completion for various languages
Plugin 'majutsushi/tagbar'              " Code tags for C/C++ languages
Plugin 'chrisbra/csv.vim'               " CSV support

" Visual
Plugin 'Yggdroot/indentLine'            " Custom char at indentation levels
Plugin 'vim-airline/vim-airline'        " Custom status line
Plugin 'vim-airline/vim-airline-themes' " Airline themes
Plugin 'edkolev/tmuxline.vim'           " Vim status line as tmux status line
Plugin 'chriskempson/base16-vim'        " base16 colors for vim
Plugin 'luochen1990/rainbow'            " Assign colors to matching brackets

call vundle#end()                       " Plugins must be added before this line
filetype plugin indent on


" EDITOR/CODE/NAVIGATION SETTINGS
" Vim settings
set showcmd                             " Show (partial) command in status line
set showmatch                           " Show matching brackets
set ignorecase                          " Do case insensitive matching
set smartcase                           " Do smart case matching
set incsearch                           " Incremental search
set hidden                              " Hide buffers when they are abandoned
set laststatus=2                        " Always show status line
set mouse=a                             " Enable mouse usage (all modes)
set number                              " Show line number
set relativenumber                      " Use relative line number
set cursorline                          " Highlight current cursor line
set scrolloff=2                         " Keep 2 lines around cursorline
set timeoutlen=250                      " Fixes slow mode changes
set undofile                            " Saves undo tree to file
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1     " Change cursor shape in insert mode
let mapleader=" "                       " Set leader key

" Vim Autocommands
au FocusGained * :redraw!               " Redraw console on focus gain
au InsertEnter * :set norelativenumber  " Set to absolute line number in Insert
au InsertLeave * :set relativenumber    " Set to relative again on exit Insert

" Syntastic settings
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'
"
" Tagbbar settings
let g:tagbar_width=25
let g:tagbar_sort=0

" Rainbow parentheses setting
let g:rainbow_active=1

" YCM settings
let g:ycm_extra_conf_globlist=['~/dev/*', '~/src/*', '~/.vim', '!~/*']
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"

" NERDTree settings
let NERDTreeWinSize=25
let NERDTreeSortOrder=['\/$', '\.c$', '\.cc$', '\.h', '*', '\.*$']
let NERDTreeHijackNetrw=1
let NERDTreeChDirMode=2


" INDENTATION
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set cindent
set colorcolumn=80

" indentLine settings
let g:indentLine_char='┊'
let g:indentLine_enabled=1
let g:indentLine_LeadingSpaceEnabled=1
let g:indentLine_LeadingSpaceChar = '·'


" INTERFACE/COLORS
set background=dark
let base16colorspace=256                " Set base16-colorspace
colorscheme base16-default-dark         " Use base16 shell colorscheme

" Custom highlight settings
set listchars=tab:··,trail:·
hi NonText      ctermfg=236 ctermbg=NONE
hi SpecialKey   ctermfg=239 ctermbg=NONE
hi CursorLineNr ctermfg=172 ctermbg=NONE cterm=bold
hi Normal       ctermbg=NONE
hi LineNr       cterm=bold
hi Comment      cterm=italic
hi Statement    cterm=bold
hi Conditional  cterm=bold
hi Repeat       cterm=bold
hi Function     cterm=bold
hi StorageClass cterm=bold
hi Structure    cterm=bold
hi Macro        cterm=bold
hi Keyword      cterm=bold
hi Type         cterm=bold

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#tabline#enabled=1


" CUSTOM KEY MAPPINGS
" Plugin key mappings
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <F1> :NERDTreeTabsToggle<CR>
nnoremap <F2> :TagbarToggle<CR>
nnoremap <F3> :MundoToggle<CR>

vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>yy "+yy

vnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>pp "+P

" Vim key mappings
nnoremap <esc> :noh<return><esc>

