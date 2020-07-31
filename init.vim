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
set showtabline=2
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
set hlsearch                            " Highlight query
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
set textwidth=80
" Fold settings
set foldmethod=indent
set nofoldenable
set foldnestmax=5
set foldlevel=2

" Autocommands
augroup GENERAL
  au!
  " Open file from previous buffer position
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au FocusGained * :redraw!               " Redraw console on focus gain
  au InsertEnter * :set norelativenumber  " Set to absolute line number in Insert
  au InsertLeave * :set relativenumber    " Set to relative again on exit Insert
  " Trigger `autoread` when files changes on disk
  au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  " Notification after file change
  au FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  au FileType netrw setl bufhidden=wipe   " Wipe netrw buffer after usage
  au FileType php setl shiftwidth=4 tabstop=4
  au FileType python setl shiftwidth=4 tabstop=4
  au FileType go setl shiftwidth=4 tabstop=4
  " Get highlight-group beneath cursor
  function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun
  " Auto install Plug if not found
  if has('nvim')
    let plug_path='~/.config/nvim'
  else
    let plug_path='~/.vim'
  endif
  if empty(glob(plug_path.'/autoload/plug.vim'))
    silent !curl -fLo plug_path.'/autoload' --create-dirs
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    au VimEnter * PlugInstall
  endif
augroup END

" Neovim specific settings
if has('nvim')
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/bin/python3'
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif

" PLUGINS & SETTINGS
call plug#begin('~/.local/share/nvim/plugs')
" Functional
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux/vim panes
Plug 'jiangmiao/auto-pairs'             " Automatic brackets
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'mhinz/vim-signify'                " Alternative git diff in gutter
let g:signify_sign_add='▍'
let g:signify_sign_delete='▍'
let g:signify_sign_delete_first_line='▍'
let g:signify_sign_change='▍'
let g:signify_sign_show_count=0
let g:signify_sign_show_text=1
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'tpope/vim-markdown'               " Fancy highlihting for markdown
Plug 'tpope/vim-surround'               " Expands actions for surrounding pairs
Plug 'powerman/vim-plugin-autosess'
let g:autosess_dir='~/.config/nvim/autosess'
Plug 'justinmk/vim-sneak'               " incsearch as a motion
let g:sneak#label=1
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'junegunn/vim-easy-align'          " Align text around characters
Plug 'shougo/context_filetype.vim'      " detect multiple filetype in one file
Plug 'sheerun/vim-polyglot'             " Syntax highlihting for most langs
let g:polyglot_disabled=['php', 'latex']
Plug 'vim-pandoc/vim-pandoc'            " Plugin for pandoc support
let g:pandoc#spell#default_langs=['en', 'id']
let g:pandoc#formatting#mode='ha'
Plug 'vim-pandoc/vim-pandoc-syntax'     " Pandoc markdown syntax highlightin
Plug 'lervag/vimtex'                    " LaTex helper
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"Plug 'xuhdev/vim-latex-live-preview',   " LaTex preview
"      \ {'on': 'LLPStartPreview'}
Plug 'junegunn/fzf',                    " path to fzf binary
      \ {'dir': '~/.local/share/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'                 " fzf vim integration
let g:fzf_layout = {'down': '~25%'}
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Completion & Coding
Plug 'neoclide/coc.nvim',               " Code completion and navigation
      \ {'do': 'yarn install --frozen-lockfile'}
let g:markdown_fenced_languages = [
      \ 'html', 'vim', 'ruby', 'bash=sh', 'rust', 'python', 'c', 'cpp']
let g:coc_global_extensions = [
      \ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver','coc-tslint',
      \ 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-python', 'coc-yaml',
      \ 'coc-snippets', 'coc-java']
set updatetime=300                    " Smaller updatetime for CursorHold
set shortmess+=c                      " Don't show |ins-completion-menu|
Plug 'shougo/echodoc.vim'
let g:echodoc_enable_at_startup=1
Plug 'liuchengxu/vista.vim',            " Visual LSP symbol viewer
      \ {'on': 'Vista!!'}
let g:vista#renderer#enable_icon=1
let g:vista_sidebar_width=35
let g:vista_default_executive='coc'
let g:vista_finder_alternative_executives=['ctags']
Plug 'w0rp/ale'                         " Code Linting and fixing
let g:ale_enabled=0
let g:ale_fixers=
      \ {'c': ['clang-format'], 'cpp': ['clang-format'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'java': ['google_java_format'], 'javascript': ['eslint'],
      \ 'php': ['php_cs_fixer', 'phpcbf'], 'python': ['black']}
let g:ale_fix_on_save=0
let g:ale_set_highlights=0
let g:ale_sign_offset=1
let g:ale_sign_error='▍'
let g:ale_sign_warning='▍'
Plug 'jpalardy/vim-slime',              " Send code to external REPL
      \ {'on': ['SlimeRegionSend', 'SlimeParagraphSend']}
let g:slime_no_mappings=1
let g:slime_target='tmux'
let g:slime_paste_file="$HOME/.config/nvim/slime_paste"
" Assume REPL is in previous tmux pane (usually bottom left)
let g:slime_default_config=
      \ {"socket_name": "default", "target_pane": "{previous}"}
let g:slime_dont_ask_default=1
Plug 'sakhnik/nvim-gdb',                " Call debugger and set breakpoints
      \ {'do': ':!./install.sh \| UpdateRemotePlugins'}
let g:nvimgdb_disable_start_keymaps=1
let g:nvimgdb_config_override=
      \ {'codewin_command': 'vne'}
Plug 'tweekmonster/startuptime.vim',
      \ {'on': 'StartupTime'}

" Visual
Plug 'chriskempson/base16-vim'          " base16 colors for vim
Plug 'Yggdroot/indentLine'              " Custom char at indentation levels
let g:indentLine_char='▏'
let g:indentLine_enabled=1
let g:indentLine_faster=1
let g:indentLine_concealcursor=''
Plug 'mike-hearn/base16-vim-lightline'
Plug 'mengelbrecht/lightline-bufferline'
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#shorten_path=1
let g:lightline#bufferline#filename_modifier = ':~:.'
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#number_map = {
      \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
      \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
let g:lightline#bufferline#unicode_symbols=1
let g:lightline#bufferline#clickable=1
let g:lightline#bufferline#read_only=''
let g:lightline#bufferline#number_separator=''
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'base16_default_dark',
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['close']]},
      \ 'tabline_subseparator': {'left': '', 'right': ''},
      \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
      \ 'component_type': {'buffers': 'tabsel'},
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'FugitiveHead'}
      \ }
let g:lightline.enable={'statusline': 1, 'tabline': 1}
let g:lightline.component_raw={'buffers': 1}
let g:lightline.enable={'statusline': 1, 'tabline': 1}
Plug 'edkolev/tmuxline.vim',            " Vim status line as tmux status line
      \ {'do': ':Tmuxline lightline powerline'}
let g:tmuxline_separators = {
      \ 'left': '', 'left_alt': '▏', 'right': '', 'right_alt': ''}
Plug 'luochen1990/rainbow'              " Assign colors to matching brackets
let g:rainbow_active=1
let g:rainbow_conf={'ctermfgs': [6,4,3,5,12,11]}
Plug 'ryanoasis/vim-devicons'           " Pretty icons in popular plugins
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1
call plug#end()

" Plugin-related autocommands
augroup PLUG
  au!
  " Close coc.nvim completion preview window after completing
  au CompleteDone * if pumvisible() == 0 | pclose | endif
  " Highlight symbol under cursor on coc.nvim CursorHold
  au CursorHold * silent call CocActionAsync('highlight')
  " Show documentation depending on whether it's vim-related or not
  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  " Search for string in current dir using rg/fzf
  command! -bang -nargs=* Find
        \ call fzf#vim#grep(
        \   'rg --column -F -i -n --no-heading --hidden -L -g "!.git/*" '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(
        \     {'options': '--delimiter : --nth 4..'}, 'right:70%:hidden', '?'),
        \   <bang>0)
  " Pritty print git graph
  command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
  " Set lightline bufferline colours
  au VimEnter * call SetupLightlineColors()
  function SetupLightlineColors() abort
    " transparent background in statusbar
    let l:palette = lightline#palette()
    let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
    let l:palette.inactive.left = l:palette.normal.middle
    let l:palette.tabline.middle = l:palette.normal.middle
    let l:palette.tabline.tabsel = l:palette.normal.left
    call lightline#colorscheme()
  endfunction
  " Functions for lightline status line
  function! LightlineReadonly()
    return &readonly ? '' : ''
  endfunction
augroup END

" INTERFACE/COLORS
set background=dark
let base16colorspace=256
colorscheme base16-default-dark
let g:indentLine_color_term=19

" Custom highlight settings
hi nontext               ctermfg=236 ctermbg=NONE
hi specialkey            ctermfg=239 ctermbg=NONE
hi cursorlinenr          ctermfg=16  cterm=bold
hi linenr                ctermfg=19  ctermbg=NONE
hi normal                ctermbg=NONE
hi comment               cterm=italic
hi function              cterm=bold
hi conditional           cterm=bold
hi repeat                cterm=bold,italic
hi label                 ctermfg=14  cterm=italic
hi operator              ctermfg=11
hi keyword               cterm=bold
hi identifier            cterm=bold,italic
hi exception             ctermfg=14  cterm=bold,italic
hi storageclass          cterm=bold
hi structure             cterm=bold
hi macro                 cterm=bold
hi type                  cterm=bold
hi signcolumn            ctermbg=NONE
hi signifysignadd        ctermbg=NONE
hi signifysignchange     ctermbg=NONE
hi signifysigndelete     ctermfg=11  ctermbg=NONE
hi aleerrorsign          ctermfg=01
hi alewarningsign        ctermfg=03  cterm=bold
hi tagbarfoldicon        ctermfg=04
hi sneak                 ctermfg=00  ctermbg=yellow


" CUSTOM KEY MAPPINGS
" Plugin key mappings
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :Vista!!<CR>
nmap <F3> :Gblame<CR>
nmap <F4> :ALEFix<CR>

" EasyAlign mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-slime mappings
xmap <leader>cc <Plug>SlimeRegionSend
nmap <leader>cc <Plug>SlimeParagraphSend

" Use <Tab> and <S-Tab> to navigate coc.nvim completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remap keys for gotos
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>ii <Plug>(coc-implementation)
nmap <silent> <leader>ff <Plug>(coc-references)

" Fugitive mappings
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>

"Remap for rename current word
nmap <leader>rr <Plug>(coc-rename)

" Show documentation in preview window
nnoremap <silent> <leader>hh :call <SID>show_documentation()<CR>

" Override mode completions using FZF
nmap <leader>h :Helptags<CR>
nmap <leader>c :Commands<CR>

" Which key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"" Buffer navigation
" Delete buffer
nnoremap <leader>d :bp\|bd #<CR>
" Next buffer
nmap <C-n> :bn<CR>
" Previous buffer
nmap <C-p> :bp<CR>
" Jump to buffers 1 - 9
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)

" Normal mode mappings
" Right strip spaces
nmap <leader>r :%s/\s\+$//e<CR>
" Yank to system clipboard
vmap <leader>y "+y
" Yank line to system clipboard
nmap <leader>yy "+yy
" Paste from system clipboard
nmap <leader>p "+p
" Paste prepend from system clipboard
nmap <leader>P "+P
" Yanking in visual mode prevents cursor from jumping back to start of block
vmap y ygv<Esc>

" Fuzzy search for file
nnoremap <leader>e :Files<CR>
" Fuzzy search for text
nnoremap <leader>f :Find<CR>
" Fuzzy search for buffer
nnoremap <leader>b :Buffers<CR>
" Split pane vertically and search for file
nnoremap <leader>v :vs<CR>:Files<CR>

nmap <leader>0 ^
nmap <esc> :noh<CR>
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
