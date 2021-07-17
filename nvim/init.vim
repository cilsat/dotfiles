" VIM SETTINGS
" General settings
set hidden                              " Hide buffers when they are abandoned
set laststatus=2                        " Always show status line
set mouse=a                             " Enable mouse usage (all modes)
set lazyredraw                          " Stop unnecessary rendering
set noshowmode                          " Hide mode in status line
set linebreak                           " Break lines on word end
set encoding=utf8                       " Character encoding
set showtabline=2                       " Always show tabline on top
set completeopt=menuone,noselect        " Omnifunc completion window options
set shortmess+=c                        " Hide messages related to ins-completion
"set iskeyword-=_                        " Set _ as word separator
" Line numbering and scrolling
set number                              " Show line number
set relativenumber                      " Use relative line number
set cursorline                          " Highlight current cursor line
set scrolloff=2                         " Keep 2 lines around cursorline
set timeoutlen=300                      " Fixes slow mode changes
set signcolumn=number                   " Gutter in the line number col
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
set inccommand=split                    " Live preview substitution commands
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
set cindent
set colorcolumn=80
set textwidth=80
" Fold settings
set foldmethod=indent
set nofoldenable
set foldnestmax=5
set foldlevel=2
" Color settings
set background=dark                     " Assume a dark background
set termguicolors                       " Enable true color support
syn sync minlines=300


" PLUGINS & SETTINGS
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

call plug#begin('~/.local/share/nvim/plugs')
" Search & Navigation
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux/vim panes
Plug 'justinmk/vim-sneak'               " Incremental bigram search as a motion
let g:sneak#label=1
Plug 'nvim-lua/popup.nvim'              " Telescope dependancy for popups
Plug 'nvim-lua/plenary.nvim'            " Telescope dependancy
Plug 'nvim-telescope/telescope.nvim'    " Fuzzy search for various categories
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'andymass/vim-matchup'             " Improved % matching/navigation
Plug 'romgrk/barbar.nvim'               " Standalone lua-based tab/bufferline
let bufferline = get(g:, 'bufferline', {})
let bufferline.icons="both"
let bufferline.icon_custom_colors=v:false
let bufferline.icon_separator_active='▍'
let bufferline.icon_separator_inactive='▍'
let bufferline.maximum_padding=0
let bufferline.semantic_letters=v:false

" Enhance existing built-in functionality
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'tpope/vim-markdown'               " Fancy highlihting for markdown
Plug 'tpope/vim-surround'               " Expands actions for surrounding pairs
Plug 'tpope/vim-commentary'             " Toggle comment motion
Plug 'powerman/vim-plugin-autosess'     " Automatically save/restore sessions
let g:autosess_dir='~/.config/nvim/autosess'
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'junegunn/vim-easy-align'          " Align text around characters
Plug 'shougo/context_filetype.vim'      " Detect multiple filetype in one file
Plug 'folke/which-key.nvim',        " Helm-like display for vim mappings
      \ { 'branch': 'main', 'on': ['WhichKey', 'WhichKey!'] }

" Integrate with external tools
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'mhinz/vim-signify'                " Alternative git diff in gutter
let g:signify_disable_by_default=1
let g:signify_sign_add='▎'
let g:signify_sign_delete='▎'
let g:signify_sign_delete_first_line='▎'
let g:signify_sign_change='▎'
let g:signify_sign_show_count=0
let g:signify_sign_show_text=1
Plug 'edkolev/tmuxline.vim',            " Vim status line as tmux status line
      \ {'do': ':Tmuxline lightline powerline'}
let g:tmuxline_separators = {
      \ 'left': '', 'left_alt': '▏', 'right': '', 'right_alt': ''}
Plug 'vim-pandoc/vim-pandoc'            " Plugin for pandoc support
let g:pandoc#spell#default_langs=['en', 'id']
let g:pandoc#formatting#mode='sA'
Plug 'vim-pandoc/vim-pandoc-syntax'     " Pandoc markdown syntax highlightin
Plug 'lervag/vimtex'                    " LaTex helper
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"Plug 'xuhdev/vim-latex-live-preview',   " LaTex preview
"      \ {'on': 'LLPStartPreview'}
Plug 'iamcco/markdown-preview.nvim',    " Preview markdown from browser
      \ { 'do': 'cd app && yarn install'  }

" Completion & Coding
"Plug 'jiangmiao/auto-pairs'             " Parenthesis auto-completion
Plug 'neovim/nvim-lspconfig'            " Base config for Neovim's builtin LSP
Plug 'mfussenegger/nvim-jdtls'          " Neovim JDTLS langserver
Plug 'nvim-treesitter/nvim-treesitter'  " Neovim's treesitter implementation
"Plug 'glepnir/lspsaga.nvim',
"      \ {'branch': 'main'}
Plug 'hrsh7th/nvim-compe'               " Auto-completion using builtin LSP
Plug 'hrsh7th/vim-vsnip'                " Enable snippets during completion
Plug 'ray-x/lsp_signature.nvim'         " Function signature popup
Plug 'onsails/lspkind-nvim'             " Fancy icons/symbols for LSP popups
Plug 'honza/vim-snippets'               " Collection of various snippets
Plug 'windwp/nvim-autopairs'            " Auto-completion of bracket/quote pairs
Plug 'simrat39/symbols-outline.nvim'    " Visual LSP symbol tree sidebar
Plug 'w0rp/ale'                         " Code Linting and formatting
let g:ale_enabled=0
let g:ale_fixers=
      \ {'*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'c': ['clang-format'], 'cpp': ['clang-format'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'java': ['google_java_format'],
      \ 'javascript': ['eslint'], 'json': ['prettier'],
      \ 'php': ['php_cs_fixer'],
      \ 'python': ['black'],
      \ 'rust': ['rustfmt'], 'typescript': ['eslint'], 'xml': ['xmllint']}
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
Plug 'tweekmonster/startuptime.vim',    " Diagnose/calculate vim startup times
      \ {'on': 'StartupTime'}

" Eye Candy
Plug 'norcalli/nvim-colorizer.lua'      " Show actual color on color tags
Plug 'norcalli/nvim-base16.lua'         " base16 gui colors for neovim
Plug 'lukas-reineke/indent-blankline.nvim' " Show indent lines on blank lines too
let g:indent_blankline_char='▏'
let g:indent_blankline_filetype_exclude = ['help', 'vim']
let g:indent_blankline_buftype_exclude = ['terminal', 'popup']
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_context_patterns = [ 'class', 'function', 'method', '^if', '^while', '^for', '^try', '^object', '^table', 'block', 'arguments', '^switch' ]
Plug 'kyazdani42/nvim-web-devicons'     " Fancy icons/symbols
"Plug 'glepnir/galaxyline.nvim', {'branch': 'main'} " Vim status line
Plug 'hoob3rt/lualine.nvim'             " Lua-based status line
Plug 'p00f/nvim-ts-rainbow'             " Treesitter-based rainbow parentheses
Plug 'gillyb/stable-windows'            " Prevent jumping/scrolling windows
Plug 'machakann/vim-highlightedyank'    " Highlight yanked text
call plug#end()


" ALOHA LUAA~
luafile ~/.config/nvim/lua/gui.lua
luafile ~/.config/nvim/lua/lsp.lua


" AUTOCOMMANDS
" General autocommands
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
  " Neovim specific settings
  if has('nvim')
    let g:python_host_prog='/usr/bin/python2'
    let g:python3_host_prog='/usr/bin/python3'
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  endif
augroup END

" Code-related autocommands and functions
augroup CODE
  au!
  " Close coc.nvim completion preview window after completing
  au CompleteDone * if pumvisible() == 0 | pclose | endif
  " Pritty print git graph
  command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
augroup END


" CUSTOM KEY MAPPINGS
" Set leader key
let mapleader=" "
" Clear highlighting
nnoremap <esc> :noh<CR>
" Strafe in larger chunks
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" j k navigation on long wrapped lines
map <expr> j (v:count ? 'j' : 'gj')
map <expr> k (v:count ? 'k' : 'gk')
" Better indenting
vmap < <gv
vmap > >gv
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

" Plugin key mappings
nmap <F1> :SignifyToggle<CR>
nmap <F2> :SymbolsOutline<CR>
nmap <F3> :Git blame<CR>
nmap <F4> :ALEFix<CR>
nmap <F5> :PlugUpd<CR>
map <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Tmux navigator + tilish mappings
noremap <silent> <m-h> :TmuxNavigateLeft<cr>
noremap <silent> <m-j> :TmuxNavigateDown<cr>
noremap <silent> <m-k> :TmuxNavigateUp<cr>
noremap <silent> <m-l> :TmuxNavigateRight<cr>

" EasyAlign mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-slime mappings
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>ss <Plug>SlimeParagraphSend

" Fugitive/signify mappings
nnoremap <leader>g :lua require'telescope.builtin'.git_status{}<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

" Show documentation in preview window
nnoremap <silent> <leader>hh :call <SID>show_documentation()<CR>

" Which key
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"" Pane/Buffer navigation
" Delete buffer
nnoremap <leader>d :BufferClose<CR>
" Delete pane
nnoremap <leader>w :q<CR>
" Next buffer
nmap <C-n> :BufferNext<CR>
" Previous buffer
nmap <C-p> :BufferPrevious<CR>
" Jump to buffers 1 - 9
nmap <leader>1 :BufferGoto 1<CR>
nmap <leader>2 :BufferGoto 2<CR>
nmap <leader>3 :BufferGoto 3<CR>
nmap <leader>4 :BufferGoto 4<CR>
nmap <leader>5 :BufferGoto 5<CR>
nmap <leader>6 :BufferGoto 6<CR>
nmap <leader>7 :BufferGoto 7<CR>
nmap <leader>8 :BufferGoto 8<CR>
nmap <leader>9 :BufferGoto 9<CR>
nmap <leader>0 :BufferPick<CR>

" Normal mode mappings
" Right strip spaces
nmap <leader>r :%s/\s\+$//e<CR>

" Fuzzy searching
" Fuzzy search for file
nnoremap <leader>e <cmd>Telescope find_files<CR>
" Fuzzy search for buffer
nnoremap <leader>b <cmd>Telescope buffers<CR>
" Fuzzy search for text
nnoremap <leader>f <cmd>Telescope live_grep<CR>
" Fuzzy search for text in open files only
nnoremap <leader>g <cmd>Telescope live_grep grep_open_files=true<CR>
" Split pane vertically and search for file
nnoremap <leader>v :vs<CR><cmd>Telescope find_files<CR>
" Split pane horizontally and search for file
nnoremap <leader>s :split<CR><cmd>Telescope find_files<CR>
" Fuzzy search for help tags/docs
nmap <leader>h <cmd>Telescope help_tags<CR>
" Fuzzy search for vim commands
nmap <leader>c <cmd>Telescope commands<CR>
" LSP references
nmap gr <cmd>Telescope lsp_references<CR>

" Compe mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Saga mappings
"nnoremap <silent>ga :Lspsaga code_action<CR>
"nnoremap <silent>gf :Lspsaga lsp_finder<CR>
"nnoremap <silent>K :Lspsaga hover_doc<CR>
"nnoremap <C-k> :Lspsaga signature_help<CR>
"nnoremap <silent>gR :Lspsaga rename<CR>
"nnoremap <silent>gp :Lspsaga preview_definition<CR>
"nnoremap <M-p> :Lspsaga diagnostic_jump_prev<CR>
"nnoremap <M-n> :Lspsaga diagnostic_jump_next<CR>
