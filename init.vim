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
"set iskeyword-=_                        " Set _ as word separator
" Line numbering and scrolling
set number                              " Show line number
set relativenumber                      " Use relative line number
set cursorline                          " Highlight current cursor line
set scrolloff=2                         " Keep 2 lines around cursorline
set timeoutlen=300                      " Fixes slow mode changes
syntax sync minlines=300

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
set path+=.,**                          " Recursive 'fuzzy' find
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
" Auto install Plug if not found
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
Plug 'jiangmiao/auto-pairs'             " Automatic brackets
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'airblade/vim-gitgutter'           " Git diff in sign column
  let g:gitgutter_realtime=0
  let g:gitgutter_eager=0
  let g:gitgutter_override_sign_column_highlight=0
  let g:gitgutter_sign_added='▍'
  let g:gitgutter_sign_removed='▍'
  let g:gitgutter_sign_modified='▍'
  let g:gitgutter_sign_modified_removed='▍'
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'tpope/vim-surround'               " Expands actions for surrounding pairs
Plug 'tpope/vim-obsession'              " Save session buffers and panes
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'junegunn/vim-easy-align'          " Align text around characters
Plug 'shougo/context_filetype.vim'      " detect multiple filetype in one file
Plug 'sheerun/vim-polyglot'             " Syntax highlihting for most langs
  let g:polyglot_disable=['php']
Plug 'vim-pandoc/vim-pandoc'            " Plugin for pandoc support
  let g:pandoc#spell#default_langs=['en', 'id']
  let g:pandoc#formatting#mode='ha'
Plug 'vim-pandoc/vim-pandoc-syntax'     " Pandoc markdown syntax highlightin
Plug 'lervag/vimtex'                    " LaTex helper
Plug 'xuhdev/vim-latex-live-preview',   " LaTex preview
  \ {'on': 'LLPStartPreview'}

" Completion & Coding
Plug 'neoclide/coc.nvim',               " Code completion and navigation
  \ {'do': { -> coc#util#install() }}
  let g:markdown_fenced_languages = [
  \ 'html', 'vim', 'ruby', 'bash=sh', 'rust', 'go', 'c', 'cpp']
  let g:coc_global_extensions = [
  \ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver','coc-tslint',
  \ 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-python', 'coc-yaml',
  \ 'coc-snippets']
  set updatetime=300                    " Smaller updatetime for CursorHold
  set shortmess+=c                      " Don't show |ins-completion-menu|
Plug 'shougo/echodoc.vim'
  let g:echodoc_enable_at_startup=1
Plug 'liuchengxu/vista.vim',            " Visual LSP symbol viewer
  \ {'on': 'Vista!!'}
  let g:vista#renderer#enable_icon=1
  let g:vista_sidebar_width=30
  let g:vista_default_executive='coc'
  let g:vista_finder_alternative_executives=['ctags']
Plug 'w0rp/ale',                        " Code Linting and fixing
  \ {'for': ['c', 'cpp', 'python', 'php', 'javascript']}
  let g:ale_lint_on_text_changed=0
  let g:ale_lint_on_insert_leave=1
" Requires clang-tools-extra, eslint, autopep8 and pycodestyle through pacman
" Requires squizlabs/php_codesniffer through composer and prettier through npm
  let g:ale_linters = {
  \ 'c': ['clangtidy'], 'cpp': ['clangtidy'], 'go': ['gofmt'],
  \ 'javascript': ['eslint'], 'php': ['phpcs'], 'python': ['pycodestyle']}
  let g:ale_fixers = {
  \ 'c': ['clang-format'], 'cpp': ['clang-format'], 'go': ['gofmt', 'goimports'],
  \ 'javascript': ['eslint'], 'php': ['phpcbf'], 'python': ['yapf']}
  let g:ale_fix_on_save=0
  let g:ale_set_highlights=0
  let g:ale_sign_offset=1
  let g:ale_sign_error='▍'
  let g:ale_sign_warning='▍'

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
  \ 'left': '', 'left_alt': '│', 'right': '', 'right_alt': '│'}
Plug 'vim-airline/vim-airline'          " Custom status line
  let g:airline_powerline_fonts=1
  let g:airline_theme='base16'
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#buffer_idx_mode=1
  let g:airline#extensions#tabline#buffers_label='b'
  let g:airline#extensions#tabline#tabs_label = 't'
  let g:airline#extensions#tabline#overflow_marker = '❯'
  let g:airline#extensions#tabline#fnametruncate=15
  let g:airline#extensions#tagbar#enabled=1
  let g:airline_left_sep=''
  let g:airline_left_alt_sep='│'
  let g:airline_right_sep=''
  let g:airline_right_alt_sep='│'
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'luochen1990/rainbow'              " Assign colors to matching brackets
  let g:rainbow_active=1
"Plug 'ryanoasis/vim-devicons'           " Pretty icons in popular plugins
"  let g:WebDevIconsUnicodeDecorateFolderNodes=1
"  let g:DevIconsEnableFoldersOpenClose=1
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
hi gitgutterdelete ctermfg=11 ctermbg=NONE
hi gitgutterchangedelete ctermfg=11 ctermbg=NONE
hi aleerrorsign ctermfg=01
hi alewarningsign ctermfg=03 cterm=bold
hi tagbarfoldicon ctermfg=04


" CUSTOM KEY MAPPINGS
" Plugin key mappings
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :Vista!!<CR>
nmap <F3> :Gblame<CR>
nmap <F4> :ALEFix<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

imap <C-;> <Plug>(neosnippet_expand_or_jump)
smap <C-;> <Plug>(neosnippet_expand_or_jump)
xmap <C-;> <Plug>(neosnippet_expand_target)

" coc.nvim functions and mappings
" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dt <Plug>(coc-type-definition)
nmap <silent> <leader>di <Plug>(coc-implementation)
nmap <silent> <leader>df <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Buffer navigation
nnoremap <leader>b :buffers<CR>:buffer<Space>
nmap <C-n> <Plug>AirlineSelectNextTab
nmap <C-p> <Plug>AirlineSelectPrevTab
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
nnoremap <leader>d :bp\|bd #<CR>

nmap <leader>0 ^
nmap <esc> :noh<CR>
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
