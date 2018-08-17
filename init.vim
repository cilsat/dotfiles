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
set linebreak                           " Break lines on word end
set encoding=utf8                       " Character encoding
" Line numbering and scrolling
set number                              " Show line number
set relativenumber                      " Use relative line number
set cursorline                          " Highlight current cursor line
set scrolloff=2                         " Keep 2 lines around cursorline
set timeoutlen=250                      " Fixes slow mode changes
" Undo
set undofile                            " Saves undo tree to file
set undodir=~/.config/nvim/undo         " Directory to save undo file
set noswapfile                          " Swap file become unnecessary
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
set path+=.,**                            " Recursive 'fuzzy' find
set wildmode=list:longest,list:full     " Lazy file name tabe completion
set wildmenu                            " Display all matching files on tab
set wildignorecase
" Indentation settings
set backspace=indent,eol,start          " allow bs over autoindent, eol, start
set softtabstop=2
set tabstop=2
set shiftwidth=2
set shiftround                          " rounds number of spaces to indent
set expandtab
set autoindent
set smartindent
set cindent
set colorcolumn=80
set textwidth=79
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
if has('nvim')
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/bin/python3'
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif

" PLUGINS & SETTINGS
" Auto install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup PLUG
    au!
    autocmd VimEnter * PlugInstall
  augroup END
endif

call plug#begin('~/.local/share/nvim/plugs')
" Functional
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux/vim panes
Plug 'scrooloose/nerdtree',             " Filesystem navigator
  \ {'on': 'NERDTreeToggle'}
  let NERDTreeWinSize=25
  let NERDTreeSortOrder=['\/$', '\.c$', '\.cc$', '\.h', '*', '\.*$']
  let NERDTreeChDirMode=2
  let NERDTreeMinimalUI=1
Plug 'xuyuanp/nerdtree-git-plugin',     " Git status in nerdtree
  \ {'on': 'NERDTreeToggle'}
Plug 'jiangmiao/auto-pairs'             " Automatic brackets
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'airblade/vim-gitgutter'           " Git diff in sign column
  let g:gitgutter_override_sign_column_highlight=0
  let g:gitgutter_sign_added='▎'
  let g:gitgutter_sign_removed='▎'
  let g:gitgutter_sign_modified='▎'
  let g:gitgutter_sign_modified_removed='▎'
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'tpope/vim-surround'               " Expands actions for surrounding pairs
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'junegunn/vim-easy-align'          " Align text around characters
Plug 'shougo/context_filetype.vim'      " detect multiple filetype in one file
Plug 'sheerun/vim-polyglot'             " Syntax hihglihting for most langs
Plug 'vim-pandoc/vim-pandoc'            " Plugin for pandoc support
  let g:pandoc#spell#default_langs=['en', 'id']
  let g:pandoc#formatting#mode='ha'
Plug 'vim-pandoc/vim-pandoc-syntax'     " Pandoc markdown syntax highlightin
Plug 'lervag/vimtex'                    " LaTex helper
Plug 'xuhdev/vim-latex-live-preview',   " LaTex preview
  \ {'on': 'LLPStartPreview'}

" Completion & Coding
" Supertab to prevent CTS
Plug 'ervandew/supertab'
  let g:SuperTabMappingForward='<s-tab>'
  let g:SuperTabMappingBackward='<tab>'
" Language Server Protocol
" The required servers must be installed separately
Plug 'autozimu/languageclient-neovim',
  \ {'branch': 'next', 'do': 'bash install.sh'}
  let g:LanguageClient_serverCommands = {
  \ 'c': ['cquery', '--language-server', '--log-file=~/.cache/cquery/cq.log',
  \   '--init={"cacheDirectory": "/home/cilsat/.cache/cquery",
  \   "cacheFormat": "msgpack"}'],
  \ 'cpp': ['cquery', '--language-server', '--log-file=~/.cache/cquery/cq.log',
  \   '--init={"cacheDirectory": "/home/cilsat/.cache/cquery",
  \   "cacheFormat": "msgpack"}'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'php': ['phpls'],
  \ 'python': ['pyls'],
  \ 'rust': ['rustup', 'run', 'stable', 'rls'],
  \ }
  set omnifunc=LanguageClient#complete
  let g:LanguageClient_settingsPath=expand('~/.config/nvim/settings.json')
  let g:LanguageClient_loadSettings=1
  let g:LanguageClient_diagnosticsEnable=0
  let g:LanguageClient_changeThrottle=0.1
" Deoplete Asynchronous completion
if has('nvim')
  Plug 'shougo/deoplete.nvim',
    \ {'do': ':UpdateRemotePlugins'}
else
  Plug 'shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
  let g:deoplete#enable_at_startup=1
  let g:deoplete#num_processes=2
  let g:deoplete#auto_complete_delay=100
  au InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
Plug 'shougo/echodoc.vim'
  let g:echodoc_enable_at_startup=1
" Tagbar displays tags for various languages
Plug 'majutsushi/tagbar',
  \ {'on': 'TagbarToggle'}
  let g:tagbar_width=25
  let g:tagbar_autofocus=1
  let g:tagbar_compact=1
  let g:tagbar_sort=0
  let g:tagbar_iconchars = ['▸', '▾']
Plug 'vim-php/tagbar-phpctags.vim',     " Display PHP ctags with phpctags
  \ {'on': 'TagbarToggle'}
" Snippets
Plug 'shougo/neosnippet'                " Snippet engine
  let g:neosnippet#expand_word_boundary=1
Plug 'shougo/neosnippet-snippets'       " Basic snippets
" Ale
Plug 'w0rp/ale',                        " Linting for various languages
  \ {'for': ['c', 'cpp', 'python', 'php', 'javascript']}
  let g:ale_lint_on_text_changed=0
  let g:ale_lint_on_insert_leave=1
" Requires clang-tools-extra, eslint, autopep8 and pycodestyle through pacman
" Requires squizlabs/php_codesniffer through composer and prettier through npm
  let g:ale_linters = {
  \ 'c': ['clangtidy'], 'cpp': ['clangtidy'], 'javascript': ['eslint'],
  \ 'php': ['phpcs'], 'python': ['pycodestyle']}
  let g:ale_fixers = {
  \ 'c': ['clang-format'], 'cpp': ['clang-format'], 'javascript': ['eslint'],
  \ 'php': ['phpcbf'], 'python': ['autopep8']}
  let g:ale_fix_on_save=0
  let g:ale_set_highlights=0
  let g:ale_sign_offset=1
  let g:ale_sign_error='▎'
  let g:ale_sign_warning='▎'

" Visual
Plug 'chriskempson/base16-vim'          " base16 colors for vim
Plug 'Yggdroot/indentLine'              " Custom char at indentation levels
  "let g:indentLine_char='┊'
  let g:indentLine_enabled=1
  let g:indentLine_faster=1
  let g:indentLine_concealcursor=''
Plug 'mkitt/tabline.vim',               " Formatting for tabs
Plug 'edkolev/tmuxline.vim'             " Vim status line as tmux status line
  \ {'do': ':Tmuxline airline tmux'}
let g:tmuxline_separators = {
  \ 'left': '',
  \ 'left_alt': '│',
  \ 'right': '',
  \ 'right_alt': '│',
  \ }
Plug 'vim-airline/vim-airline'          " Custom status line
  let g:airline_powerline_fonts=1
  let g:airline_theme='base16'
  let g:airline#extensions#tabline#enabled=1
  "let g:airline#extensions#tabline#tab_nr_type=1
  let g:airline#extensions#tabline#buffer_idx_mode=1
  let g:airline_left_sep=''
  let g:airline_left_alt_sep='│'
  let g:airline_right_sep=''
  let g:airline_right_alt_sep='│'
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'luochen1990/rainbow'              " Assign colors to matching brackets
  let g:rainbow_active=1
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'           " Pretty icons in popular plugins
  let g:WebDevIconsUnicodeDecorateFolderNodes=1
  let g:DevIconsEnableFoldersOpenClose=1
call plug#end()


" INTERFACE/COLORS
set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-default-dark
endif
let g:indentLine_color_term=18

" Custom highlight settings
hi nontext      ctermfg=236 ctermbg=NONE
hi specialkey   ctermfg=239 ctermbg=NONE
hi cursorlinenr ctermfg=172 ctermbg=NONE cterm=bold
hi linenr       ctermbg=NONE
hi normal       ctermbg=NONE
hi comment      cterm=italic
hi conditional  cterm=bold
hi repeat       cterm=bold
hi function     cterm=bold
hi storageclass cterm=bold
hi structure    cterm=bold
hi macro        cterm=bold
hi keyword      cterm=bold
hi type         cterm=bold
hi signcolumn   ctermbg=NONE
hi gitgutteradd ctermbg=NONE
hi gitgutterchange ctermbg=NONE
hi gitgutterdelete ctermbg=NONE
hi gitgutterchangedelete ctermbg=NONE
hi aleerrorsign ctermfg=01
hi alewarningsign ctermfg=03 cterm=bold
hi tagbarfoldicon ctermfg=04


" CUSTOM KEY MAPPINGS
" Plugin key mappings
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :TagbarToggle<CR>
nmap <F3> :Gblame<CR>
nmap <F4> :ALEFix<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)
xmap <C-l> <Plug>(neosnippet_expand_target)

nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nmap <silent> <F5> :call LanguageClient_textDocument_rename()<CR>

" Buffer navigation
nmap <C-n> :bnext<CR>
nmap <C-p> :bprevious<CR>
nnoremap <leader>ls :buffers<CR>:buffer<Space>

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Vim mappings
nmap <leader>r :%s/\s\+$//e<CR>
vmap <leader>y "+y
nmap <leader>Y "+yg_
nmap <leader>yy "+yy

nmap <leader>p "+p
nmap <leader>P "+P
nmap <leader>pp "+P

nnoremap <leader>e :e **/*
nnoremap <leader>v :vs **/*

nmap <leader>0 ^
nmap <esc> :noh<CR>
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
