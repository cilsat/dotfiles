runtime! ubuntu.vim

" These settings are probably permanent
filetype off
syntax enable
set background=dark
set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set smartcase               " Do smart case matching
set incsearch               " Incremental search
set autowrite               " Automatically save before commands like :next and :make
set hidden                  " Hide buffers when they are abandoned
set mouse=a                 " Enable mouse usage (all modes)
set number                  " Show line numbers
set laststatus=2            " Always show status line
set t_Co=256                " Ensures 256 colors for tmux. Put before set colorscheme
let base16colorspace=256    " Ensures 256 colors for base16-colorspace
set cursorline              " Show cursor line
au FocusGained * :redraw!   " Redraw console on focus gain
set timeoutlen=50           " Fixes slow mode changes

set softtabstop=4
set tabstop=4
set shiftwidth=4
"set expandtab
set listchars=tab:>.,eol:$

" FUNCTIONS AND KEYBINDINGS
" Reveals syntax highlight group of element under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Jump to last position upon reopening file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" PLUGINS
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Functionality
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'Yggdroot/indentLine'

" Autocompletion
"Plugin 'Valloric/YouCompleteMe'

" Visual enhancement
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'scrooloose/syntastic'

" Color schemes
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'

" All plugins must be added before the following lines
call vundle#end()
filetype plugin indent on

" Airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#tabline#enabled=1

" tmux.vim settings
let g:tmuxline_preset='full'
let g:tmuxline_theme='vim_powerline'

" YCM settings
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" COLORSCHEME
" Set colorscheme
colorscheme mustang

" Indent settings
"set omnifunc=syntaxComplete#Complete
"let g:indentLine_char='·┆┊'
"let g:indent"line_co"lor_term = 237
"let g:indent"line_enab"led=0
"let g:indent"line_"leadingSpaceEnab"led=0
"let g:indent"line_"leadingSpaceChar = '·'

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=NONE
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermfg=242 ctermbg=238 cterm=NONE

set list listchars=tab:╎·,trail:·,precedes:·,eol:¶,nbsp:~
hi NonText      guifg=#808080 guibg=NONE     gui=NONE ctermfg=238 ctermbg=NONE
hi SpecialKey   guifg=#808080 guibg=#202020 gui=NONE ctermfg=239 ctermbg=NONE

