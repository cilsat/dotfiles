" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim
let path='~/vimfiles/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" My plugins~
" Sensible Vim
Plugin 'tpope/vim-sensible'
" NERD Tree
Plugin 'scrooloose/nerdtree'
" Syntastic
Plugin 'scrooloose/syntastic'
" Airline
Plugin 'bling/vim-airline'
" Bufferline
Plugin 'bling/vim-bufferline'
" Powershell script syntax highlighting
Plugin 'PProvost/vim-ps1'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Set Windows/Powershell as env
"source $VIMRUNTIME/mswin.vim
"behave mswin
set shell=powershell
set shellcmdflag=-command
" Windows diff hack
set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '"' . $VIMRUNTIME . '\diff"'
            let eq = '""'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Airline settings
"set laststatus=2
set encoding=utf-8
set t_Co=256
let g:airline_detect_whitespace=0
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline#extensons#tabline#enabled=1

set nu
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set cindent
set paste
set cursorline

" GVim settings
set gfn=Fira_Mono_for_Powerline:h8:cANSI
colorscheme desert
