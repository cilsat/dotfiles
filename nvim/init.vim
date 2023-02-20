" PLUGINS & SETTINGS
" Auto install Plug if not found
let plug_path='~/.config/nvim'
if empty(glob(plug_path.'/autoload/plug.vim'))
  silent !curl -fLo plug_path.'/autoload' --create-dirs
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugs')
" Completion & Coding
Plug 'neovim/nvim-lspconfig'            " Base config for Neovim's builtin LSP
Plug 'nvim-treesitter/nvim-treesitter'  " Neovim's treesitter implementation
Plug 'nvim-treesitter/playground'       " Treesitter queries directly in neovim
Plug 'nvim-treesitter/nvim-treesitter-textobjects'  " Neovim's treesitter implementation
Plug 'hrsh7th/nvim-cmp'                 " Auto-completion using builtin LSP
Plug 'hrsh7th/cmp-nvim-lsp'             " nvim-lsp completion source
Plug 'hrsh7th/cmp-nvim-lsp-signature-help' "nvim-lsp functin signature helper
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol' "display document symbols in search function
Plug 'hrsh7th/cmp-buffer'               " buffer words completion source
Plug 'hrsh7th/cmp-path'                 " path completion source
Plug 'ray-x/cmp-treesitter'             " treesitter completion source
Plug 'onsails/lspkind-nvim'             " Fancy icons/symbols for LSP popups
Plug 'saadparwaiz1/cmp_luasnip'         " luasnip completion source
Plug 'l3mon4d3/luasnip'                 " Lua-based vscode snippets
Plug 'rafamadriz/friendly-snippets'     " Collection of snippets for various languages
Plug 'mfussenegger/nvim-jdtls'          " Neovim JDTLS langserver
Plug 'simrat39/rust-tools.nvim'         " Improved rust experience (inlays, etc)
Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'  " Generic LSP for formatting, linting, etc
Plug 'windwp/nvim-autopairs'            " Auto-completion of bracket/quote pairs
Plug 'pwntester/octo.nvim'              " Repo PR/MR editing directly from vim

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
" Search & Navigation
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux/vim panes
Plug 'ggandor/leap.nvim'                " Navigate within buffer
Plug 'nvim-lua/popup.nvim'              " Telescope dependancy for popups
Plug 'nvim-lua/plenary.nvim'            " Telescope dependancy
Plug 'nvim-telescope/telescope.nvim'    " Fuzzy search for various categories
Plug 'nvim-telescope/telescope-fzf-native.nvim' " FZF C port for telescope
Plug 'romgrk/barbar.nvim'               " Standalone lua-based tab/bufferline
Plug 'elihunter173/dirbuf.nvim'         " Rename files/dirs as nvim buffer

" Enhance existing built-in functionality
Plug 'tpope/vim-repeat'                 " Expands repeatable actions/gestures
Plug 'kylechui/nvim-surround'           " Expands actions for surrounding pairs
Plug 'tpope/vim-commentary'             " Toggle comment motion
Plug 'rmagatti/auto-session'            " Automatically save/restore sessions
Plug 'rmagatti/session-lens'            " Telescope extension for auto-session
Plug 'wellle/targets.vim'               " Expands text object actions/gestures
Plug 'vim-scripts/VisIncr'              " Expands autoincrement functions
Plug 'tweekmonster/startuptime.vim',    " Diagnose/calculate vim startup times
      \ {'on': 'StartupTime'}
Plug 'lewis6991/impatient.nvim'         " Lua caching for improved startup
Plug 'kevinhwang91/promise-async'       " Required for nvim-ufo
Plug 'kevinhwang91/nvim-ufo'            " Modern neovim folding

" Integrate with external tools
Plug 'tpope/vim-fugitive'               " Git wrapper for vim
Plug 'sindrets/diffview.nvim'           " Git diff tabpage view
  set fillchars+=diff:╱
Plug 'mhinz/vim-signify'                " Alternative git diff in gutter
  let g:signify_disable_by_default=0
  let g:signify_sign_add='▎'
  let g:signify_sign_delete='▎'
  let g:signify_sign_delete_first_line='▎'
  let g:signify_sign_change='▎'
  let g:signify_sign_show_count=0
  let g:signify_sign_show_text=1
Plug 'lervag/vimtex'                    " LaTex helper
  let g:tex_flavor='latex'
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
Plug 'iamcco/markdown-preview.nvim',    " Preview markdown from browser
      \ { 'do': 'cd app && yarn install'  }

Plug 'nvim-lualine/lualine.nvim'        " Lua-based status line
Plug 'p00f/nvim-ts-rainbow'             " Treesitter-based rainbow parentheses
Plug 'machakann/vim-highlightedyank'    " Highlight yanked text
"Plug 'j-hui/fidget.nvim'                " LSP server progress widget
call plug#end()

" ALOHA LUAA~
lua require('impatient')
luafile ~/.config/nvim/lua/options.lua
luafile ~/.config/nvim/lua/gui.lua
luafile ~/.config/nvim/lua/lsp.lua
lua << EOF
local opts = {
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enable_last_session = true,
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = nil
}
require('auto-session').setup(opts)
EOF

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
  " Close popup menu after completion
  au CompleteDone * if pumvisible() == 0 | pclose | endif
  " Neovim specific settings
  let g:python_host_prog='/usr/bin/python2'
  let g:python3_host_prog='/usr/bin/python3'
  "set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
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

" Shift + J/K moves selected lines down/up in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Plugin key mappings
nmap <F1> :DiffviewOpen<CR>
nmap <F2> :Dirbuf<CR>
nmap <F3> :Git blame<CR>
" <F4> set in lsp.lua
"nmap <F4> :lua vim.lsp.buf.format({timeout_ms = 2000, async = true})<CR>
nmap <F5> :PlugUpd<CR>
nmap <F6> :SaveSession<CR>

nmap <F10> :call SynGroup()<CR>

" EasyAlign mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-slime mappings
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>ss <Plug>SlimeParagraphSend

" Which key
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"" Pane/Buffer navigation
" Delete buffer
nnoremap <leader>d :BufferClose<CR>
" Delete pane
nnoremap <leader>w :q<CR>
" Write and delete pane
nnoremap <leader>x :wq<CR>
" Next buffer
nnoremap <C-n> :BufferNext<CR>
" Previous buffer
nnoremap <C-p> :BufferPrevious<CR>
" Jump to buffers 1 - 9
nnoremap <silent> <leader>1 :BufferGoto 1<CR>
nnoremap <silent> <leader>2 :BufferGoto 2<CR>
nnoremap <silent> <leader>3 :BufferGoto 3<CR>
nnoremap <silent> <leader>4 :BufferGoto 4<CR>
nnoremap <silent> <leader>5 :BufferGoto 5<CR>
nnoremap <silent> <leader>6 :BufferGoto 6<CR>
nnoremap <silent> <leader>7 :BufferGoto 7<CR>
nnoremap <silent> <leader>8 :BufferGoto 8<CR>
nnoremap <silent> <leader>9 :BufferGoto 9<CR>
nnoremap <silent> <leader>0 :BufferLast<CR>

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
" Fuzzy search within buffer
nnoremap <leader>/ :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
" Fuzzy search for help tags/docs
nmap <leader>h <cmd>Telescope help_tags<CR>
" Fuzzy search for vim commands
nmap <leader>c <cmd>Telescope commands<CR>
" LSP references
nmap gr <cmd>Telescope lsp_references<CR>
