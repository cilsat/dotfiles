" STARTUP
" Open file from previous buffer position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" VIM SETTINGS
" General settings
let mapleader=" "                       " Set leader key
set hidden                              " Hide buffers when they are abandoned
set laststatus=2                        " Always show status line
set mouse=a                             " Enable mouse usage (all modes)
set lazyredraw                          " Stop unnecessary rendering
set noshowmode                          " Hide mode in status line
" Line numbering and scrolling
set number                              " Show line number
set relativenumber                      " Use relative line number
set cursorline                          " Highlight current cursor line
set scrolloff=2                         " Keep 2 lines around cursorline
set timeoutlen=250                      " Fixes slow mode changes
" Undo tree
set undofile                            " Saves undo tree to file
set undodir=~/.config/nvim/undo         " Directory to save undo file
set noswapfile
" Matching
set showcmd                             " Show (partial) command in status line
set showmatch                           " Show matching brackets
set ignorecase                          " Do case insensitive matching
set smartcase                           " Do smart case matching
set infercase
" Searching
set hlsearch
set incsearch                           " Incremental search
set gdefault                            " Add /g flag on :s by default
set path+=**                            " Recursive 'fuzzy' find
set wildmode=longest,list,full          " Lazy file name tabe completion
set wildmenu                            " Display all matching files on tab
set wildignorecase
" Indentation settings
set backspace=indent,eol,start          " allow bs over autoindent, eol, start
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set cindent
set colorcolumn=80
" Fold settings
set foldmethod=indent
set nofoldenable
set foldnestmax=5
set foldlevel=2
" Autocommands
au FocusGained * :redraw!               " Redraw console on focus gain
au InsertEnter * :set norelativenumber  " Set to absolute line number in Insert
au InsertLeave * :set relativenumber    " Set to relative again on exit Insert
au FileType php setlocal shiftwidth=4 tabstop=4
au FileType python setlocal shiftwidth=4 tabstop=4
" Neovim specific settings
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'


" PLUGINS & SETTINGS
" Auto install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup PLUG
    au!
    autocmd VimEnter * PlugInstall
  augroup END
endif

call plug#begin('~/.config/nvim/plugged')
" Functional
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux/vim panes
Plug 'scrooloose/nerdtree',             " Filesystem navigator
  \{'on': 'NERDTreeTabsToggle'}
  let NERDTreeWinSize=25
  let NERDTreeSortOrder=['\/$', '\.c$', '\.cc$', '\.h', '*', '\.*$']
  let NERDTreeHijackNetrw=1
  let NERDTreeChDirMode=2
Plug 'jistr/vim-nerdtree-tabs',         " Use same nerdtree between tabs
  \{'on': 'NERDTreeTabsToggle'}
Plug 'simnalamburt/vim-mundo',          " Undo tree window
  \{'on': 'MundoToggle'}
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'chrisbra/csv.vim'                 " CSV support
Plug 'leafgarland/typescript-vim'       " Typescript syntax highlighting
Plug 'rust-lang/rust.vim'               " Rust syntax highlighting
Plug 'xuhdev/vim-latex-live-preview',   " LaTex preview
  \{'on': 'LLPStartPreview'}

" Coding
" YouCompleteMe
Plug 'valloric/youcompleteme'
  let g:ycm_extra_conf_globlist=['~/dev/*', '~/src/*', '~/.vim', '!~/*']
  let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
  let g:ycm_python_binary_path='python'   " Enables completion inside env
" Deoplete
"Plug 'shougo/deoplete.nvim',            " Autocompletion for various languages
"  \{'do': ':UpdateRemotePlugins'}
"  let g:deoplete#enable_at_startup=1
"  set completeopt-=preview              " Disable preview window
"Plug 'zchee/deoplete-jedi'              " Deoplete for Python
"  let g:deoplete#sources#jedi#server_timeout=20
"  let g:deoplete#sources#jedi#statement_length=240
"Plug 'padawan-php/deoplete-padawan'     " Deoplete for PHP
"  let g:deoplete#sources#padawan#server_autostart=1
"Plug 'tweekmonster/deoplete-clang2'
"  let g:deoplete#sources#clang#executable='/usr/bin/clang'
"Plug 'shougo/echodoc.vim'               " Show doc in status line
"  let g:echodoc_enable_at_startup=1
" Tagbar
Plug 'majutsushi/tagbar'                " Display tags for various languages
  let g:tagbar_width=25
  let g:tagbar_autofocus=1
  let g:tagbar_compact=1
  let g:tagbar_sort=0
  let g:tagbar_iconchars = ['▸', '▾']
Plug 'vim-php/tagbar-phpctags.vim'      " Display PHP ctags
" Ale
Plug 'w0rp/ale'                         " Linting for various languages
  let g:ale_lint_on_text_changed=0
  let g:ale_lint_on_insert_leave=1
  let g:ale_linters = {
  \  'c': ['clangtidy'],
  \  'cpp': ['clangtidy'],
  \  'javascript': ['eslint'],
  \  'php': ['phpcs'],
  \  'python': ['pycodestyle']}
  let g:ale_fixers = {
  \  'c': ['clang-format'],
  \  'cpp': ['clang-format'],
  \  'javascript': ['prettier'],
  \  'php': ['phpcbf'],
  \  'python': ['autopep8']}
  let g:ale_fix_on_save=1
  let g:ale_sign_error='▸'
  let g:ale_sign_warning='-'

" Visual
Plug 'Yggdroot/indentLine'              " Custom char at indentation levels
  let g:indentLine_char='┊'
  let g:indentLine_enabled=1
  let g:indentLine_LeadingSpaceEnabled=1
  let g:indentLine_LeadingSpaceChar='·'
Plug 'vim-airline/vim-airline'          " Custom status line
  let g:airline_powerline_fonts=1
  let g:airline_theme='base16'
  let g:airline#extensions#tmuxline#enabled=1
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#ale#enabled=1
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'edkolev/tmuxline.vim'             " Vim status line as tmux status line
Plug 'chriskempson/base16-vim'          " base16 colors for vim
Plug 'luochen1990/rainbow'              " Assign colors to matching brackets
  let g:rainbow_active=1
call plug#end()


" INTERFACE/COLORS
set background=dark
let base16colorspace=256              " Set base16-colorspace
colorscheme base16-default-dark         " Use base16 shell colorscheme

" Custom highlight settings
hi nontext      ctermfg=236 ctermbg=NONE
hi specialkey   ctermfg=239 ctermbg=NONE
hi cursorlinenr ctermfg=172 cterm=bold
hi linenr       ctermbg=NONE
hi normal       ctermbg=NONE
hi comment      cterm=italic
hi statement    cterm=bold cterm=italic
hi conditional  cterm=bold
hi repeat       cterm=bold
hi function     cterm=bold
hi storageclass cterm=bold
hi structure    cterm=bold
hi macro        cterm=bold
hi keyword      cterm=bold
hi type         cterm=bold
hi aleerrorsign ctermfg=01 ctermbg=18
hi tagbarfoldicon ctermfg=04


" CUSTOM KEY MAPPINGS
" Plugin key mappings
nnoremap <leader>jj :YcmCompleter GoTo<CR>
nnoremap <F1> :NERDTreeTabsToggle<CR>
nnoremap <F2> :TagbarToggle<CR>
nnoremap <F3> :MundoToggle<CR>
nnoremap <F4> :ALEFix<CR>

" Vim mappings
nnoremap <leader>r :%s/\s\+$//e<CR>
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>yy "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>pp "+P

nnoremap <esc> :noh<return><esc>
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

