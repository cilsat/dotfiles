vim.cmd [[
  syntax off
  filetype off
  filetype plugin indent off
]]

local opt = vim.opt

-- Basic appearance and behavior
opt.background = "dark" -- Assume dark background color
opt.termguicolors = true -- Use 24-bit RGB color in the terminal
opt.hidden = true -- Hide buffers when they are abandoned
opt.ruler = false -- Hide ruler
opt.mouse = 'a' -- Enable all mouse modes
opt.lazyredraw = true -- Prevent unnecessary rendering
opt.pumblend = 7 -- Popup menu transparency
-- opt.showmode = false -- Hide mode in status line
opt.showtabline = 2 -- Always show buffer/tabline
opt.completeopt = {"menuone"} -- Show ins-completion-menu when only one match
opt.shortmess:append("sIc") -- Hide vim intro (sI) and ins-completion (c)
-- opt.iskeyword:remove("_") -- Set underscore (_) as word separator
opt.updatetime = 1000 -- Update time for sign column and highlight changes
opt.timeoutlen = 300 -- Update time for mode changes, key chords
-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- Appearance of sign and line number columns
opt.number = true -- Show line number
opt.numberwidth = 2 -- Minimum width of number column
opt.relativenumber = true -- Line numbers are relative to current line
opt.signcolumn = "yes:1" -- Always show 1 char-width sign column
opt.cursorline = true -- Highlight current cursor line
opt.scrolloff = 2 -- Number of "buffer" lines surrounding cursor line

-- Save file behavior
opt.undofile = true -- Save undo tree to files
opt.undodir = vim.fn.stdpath("config") .. "/undo/" -- Undo files directory
opt.swapfile = false -- Do not use a swapfile
-- opt.shadafile = "NONE" -- Do not use shared data file

-- Builtin matching and searching
opt.showcmd = true -- Show partial command in status line
opt.showmatch = true -- Show matching brackets
opt.ignorecase = true -- Case insensitive matching in general
opt.smartcase = true -- Case sensitive when pattern contains uppercase
opt.infercase = true -- Infer case in insert mode completion
opt.hlsearch = true -- Highlight search query
opt.incsearch = true -- Incrementally highlight while searching
opt.inccommand = "split" -- Live preview substitutions in split window
opt.gdefault = true -- Add /g flag on substitutions by default

-- Indentation and linebreak behavior
opt.backspace = {"indent", "eol", "start"}
opt.linebreak = true -- Break lines on word endings
opt.whichwrap:append("<>hl") -- Navigate (h, l) across line breaks
opt.textwidth = 80 -- Maximum width of inserted text before linebreak occurs
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Number of spaces to use for each indent step
opt.cindent = true -- Use C-style indenting

-- Folding behavior
opt.foldmethod = "indent" -- Folds follow indents
opt.foldenable = false -- Do not fold by default
opt.foldnestmax = 5 -- Maximum level of nested folds
opt.foldlevel = 2 -- Level to begin folding

-- Disable internal plugins
local disabled_plugins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
  "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
  "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "spellfile_plugin",
  "matchit"
}
for _, plugin in pairs(disabled_plugins) do vim.g["loaded" .. plugin] = 0 end

-- Default floating window borders
vim.g.floating_window_border = {'🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏'}
