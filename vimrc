" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
" NOTE: debian.vim sets 'nocompatible'
runtime! ubuntu.vim
filetype off

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax enable

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Visual stuff
set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set smartcase               " Do smart case matching
set incsearch               " Incremental search
set autowrite               " Automatically save before commands like :next and :make
set hidden                  " Hide buffers when they are abandoned
if has("mouse")
    set mouse=a             " Enable mouse usage (all modes)
endif
set nu                      " Show line numbers
set laststatus=2            " Always show status line
set t_Co=256               " Ensures 256 colors. Put before set colorscheme
let base16colorspace=256    " Ensures 256 colors for base16-colorspace
set cursorline              " Show cursor line
au FocusGained * :redraw!

" Tabs
set softtabstop=4
set tabstop=8
set shiftwidth=4
set expandtab
set listchars=tab:>.,eol:$
"set foldmethod=syntax
"set foldcolumn=2

" Plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Functionality
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'

" Autocompletion
Plugin 'Valloric/YouCompleteMe'

" Visual enhancement
Plugin 'bling/vim-airline'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'scrooloose/syntastic'

" Color schemes
"Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'

" All plugins must be added before the following lines
call vundle#end()
filetype plugin indent on

" Powerline settings
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled=0

" tmux.vim settings
let g:tmuxline_preset='full'
let g:tmuxline_theme='vim_powerline'

" Indent settings
"let g:indentLine_leadingSpaceEnabled=1
"let g:indent_guides_indent_leves=20

" YCM settings
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Set color scheme
colorscheme base16-flat
