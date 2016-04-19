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
set number
set relativenumber
set cursorline              " Show cursor line
set scrolloff=2             " Keep 2 lines of context around cursorline
set laststatus=2            " Always show status line
set t_Co=256                " Ensures 256 colors for tmux. Put before set colorscheme
let base16colorspace=256    " Ensures 256 colors for base16-colorspace
au FocusGained * :redraw!   " Redraw console on focus gain
set timeoutlen=250          " Fixes slow mode changes

set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set colorcolumn=80

" Jump to last position upon reopening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Relative/absolute line numbering
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<CR>

" Set leader before loading plugins
let mapleader=" "

" PLUGINS
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'simnalamburt/vim-mundo'

" Shell
Plugin 'tpope/vim-fugitive'

" Source dev
Plugin 'wellle/targets.vim'
Plugin 'vim-scripts/VisIncr'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'

" Purely visual 
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'luochen1990/rainbow'

" All plugins must be added before the following lines
call vundle#end()
filetype plugin indent on

" COLORS
"let g:base16_shell_path="~/.config/base16-shell/"       
colorscheme base16-default

set listchars=tab:··,trail:·
hi NonText      ctermfg=236 ctermbg=NONE
hi SpecialKey   ctermfg=239 ctermbg=NONE
hi CursorLineNr ctermfg=172 ctermbg=NONE cterm=bold
"hi CursorLine   ctermbg=235 cterm=NONE
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

" Indent settings
let g:indentLine_char='┊'
"let g:indentLine_color_term = 237
let g:indentLine_enabled=1
"Let g:indentLine_LeadingSpaceEnabled=0
"Let g:indentLine_LeadingSpaceChar = '·'

" Buffer/file plugin settings
let NERDTreeHijackNetrw=1

" Syntastic settings
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol         = '✗'
let g:syntastic_style_error_symbol   = '✗'
let g:syntastic_warning_symbol       = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

"Airline settings
let g:airline_powerline_fonts=1
let g:airline_theme = 'base16'
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#tabline#enabled=1

" tagbbar settings
let g:tagbar_width=25
let g:tagbar_autoclose=1

" Rainbow parentheses setting
let g:rainbow_active=1

" YCM settings
"let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"

" Plugin key mappings
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <F2> :e %:p:h<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F4> :MundoToggle<CR>

