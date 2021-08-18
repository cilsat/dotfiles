-- Pretty icons
require'nvim-web-devicons'.setup {default = true}

-- Setup base16
vim.cmd [[
  filetype on
  filetype plugin indent on
]]
local nvim = require 'nvim'
local base16_theme
if vim.env.BASE16_THEME then
  base16_theme = require('themes.base16-'..vim.env.BASE16_THEME)
else
  base16_theme = require('themes.base16-decaf')
end
require('theme').apply_base16_theme(base16_theme, true)

-- Setup colorizer
require'colorizer'.setup()

-- Rainbow parentheses
require'nvim-treesitter.configs'.setup {
  rainbow = {enable = true, extended_mode = true}
}

-- Lualine setup
local b = {bg = nvim.g.color19, fg = nvim.g.color07}
local c = {bg = nvim.g.color18, fg = nvim.g.color08}
local fg = nvim.g.color00

require('lualine').setup {
  options = {
    theme = {
      normal = {a = {bg = nvim.g.color04, fg = fg, gui = 'bold'}, b = b, c = c},
      insert = {a = {bg = nvim.g.color02, fg = fg, gui = 'bold'}, b = b, c = c},
      visual = {a = {bg = nvim.g.color05, fg = fg, gui = 'bold'}, b = b, c = c},
      replace = {a = {bg = nvim.g.color01, fg = fg, gui = 'bold'}, b = b, c = c},
      command = {a = {bg = nvim.g.color16, fg = fg, gui = 'bold'}, b = b, c = c},
      inactive = {b = {bg = nvim.g.color19, fg = fg, gui = 'bold'}, c = c}
    },
    section_separators = '',
    component_separators = '│'
  },
  sections = {
    lualine_b = {{'filename', file_status = true}},
    lualine_c = {
      {'branch', icon = ''}, {
        'diff',
        symbols = {added = ' ', modified = '柳', removed = ' '},
        color_added = nvim.g.color08,
        color_modified = nvim.g.color08,
        color_removed = nvim.g.color08
      }
    },
    lualine_x = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn', 'info', 'hint'},
        color_error = nvim.g.color17,
        color_warn = nvim.g.color03,
        color_info = nvim.g.color06,
        color_hint = nvim.g.color08,
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      }, {'encoding', upper = true}, 'fileformat'
    }
  }
}

-- Custom editor highlight settings
local cmd = vim.cmd
local function hi(group, elements)
  local command = 'hi ' .. group
  if elements.fg ~= nil then command = command .. ' guifg=' .. elements.fg end
  if elements.bg ~= nil then command = command .. ' guibg=' .. elements.bg end
  if elements.gui ~= nil then command = command .. ' gui=' .. elements.gui end
  cmd(command)
end

-- Editor highlights
hi('Number', {fg = nvim.g.color17})
hi('Comment', {gui = 'italic'})
hi('CursorLine', {bg = nvim.g.color18})
hi('CursorLineNr', {fg = nvim.g.color07, bg = nvim.g.color18})
hi('LineNr', {fg = nvim.g.color19, bg = 'none'})
hi('SignColumn', {bg = 'none'})
hi('TagbarFoldIcon', {fg = nvim.g.color04})
hi('VertSplit', {bg = 'none'})

-- Popup menu
hi('PmenuSel', {fg = nvim.g.color07, bg = nvim.g.color19})

-- Custom plugin highlights
hi('Sneak', {fg = 'bg', bg = nvim.g.color17})
hi('HighlightedYankRegion', {bg = nvim.g.color19})
hi('IndentBlanklineChar', {fg = nvim.g.color19, bg = 'none'})
hi('IndentBlanklineContextChar', {fg = nvim.g.color08, bg = 'none'})

-- Barbar (tab/bufferline) highlights
-- Currently active/selected buffer
hi('BufferCurrent', {fg = nvim.g.color15, bg = nvim.g.color19})
hi('BufferCurrentIndex', {fg = nvim.g.color15, bg = nvim.g.color19})
hi('BufferCurrentMod',
   {gui = 'italic,bold', fg = nvim.g.color17, bg = nvim.g.color19})
hi('BufferCurrentSign', {fg = nvim.g.color04, bg = nvim.g.color19})
hi('BufferCurrentIcon', {fg = 'bg', bg = nvim.g.color04})
hi('BufferCurrentTarget',
   {gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color08})
-- Currently visible (but not active) buffer(s)
hi('BufferVisible', {fg = nvim.g.color21, bg = nvim.g.color19})
hi('BufferVisibleIndex', {fg = nvim.g.color21, bg = nvim.g.color19})
hi('BufferVisibleMod',
   {gui = 'italic,bold', fg = nvim.g.color21, bg = nvim.g.color19})
hi('BufferVisibleSign', {fg = nvim.g.colorbg, bg = nvim.g.color19})
hi('BufferVisibleIcon', {fg = nvim.g.color21, bg = nvim.g.color19})
hi('BufferVisibleTarget',
   {gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color19})
-- Inactive buffers
hi('BufferInactive', {fg = nvim.g.color20, bg = nvim.g.color18})
hi('BufferInactiveIndex', {fg = nvim.g.color20, bg = nvim.g.color18})
hi('BufferInactiveMod',
   {gui = 'italic', fg = nvim.g.color20, bg = nvim.g.color18})
hi('BufferInactiveSign', {fg = nvim.g.colorbg, bg = nvim.g.color18})
hi('BufferInactiveIcon', {fg = nvim.g.color20, bg = nvim.g.color17})
hi('BufferInactiveTarget',
   {gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color18})
-- Tab/bufferline background
hi('BufferTabpages', {fg = nvim.g.color18})
hi('BufferTabpageFill', {fg = nvim.g.colorbg, bg = nvim.g.color18})

-- Treesitter highlights
cmd('hi TSPunctBracket guifg = fg')
cmd('hi TSPunctDelimiter guifg = fg')
cmd('hi TSPunctSpecial guifg = fg')
hi('RainbowCol1', {fg = nvim.g.color06})
hi('RainbowCol2', {fg = nvim.g.color04})
hi('RainbowCol3', {fg = nvim.g.color03})
hi('RainbowCol4', {fg = nvim.g.color05})
hi('RainbowCol5', {fg = nvim.g.color12})
hi('RainbowCol6', {fg = nvim.g.color11})
hi('RainbowCol7', {fg = nvim.g.color07})

-- LSP highlights
hi('LspDiagnosticsSignError', {gui = 'italic', fg = nvim.g.color17})
hi('LspDiagnosticsSignWarning', {gui = 'italic', fg = nvim.g.color11})
hi('LspDiagnosticsSignInformation', {gui = 'italic', fg = nvim.g.color10})
hi('LspDiagnosticsSignHint', {gui = 'italic', fg = nvim.g.color14})
hi('LspReferenceRead', {gui = 'bold', bg = nvim.g.color19})
hi('LspReferenceText', {gui = 'bold', bg = nvim.g.color19})
hi('LspReferenceWrite', {gui = 'bold', bg = nvim.g.color19})
hi('LspDiagnosticsUnderlineError', {gui = 'undercurl'})
hi('LspDiagnosticsUnderlineWarning', {gui = 'undercurl'})
hi('LspDiagnosticsUnderlineInformation', {gui = 'undercurl'})
hi('LspDiagnosticsUnderlineHint', {gui = 'undercurl'})
hi('LspDiagnosticsVirtualTextError', {gui = 'italic', fg = nvim.g.color17})
hi('LspDiagnosticsVirtualTextWarning', {gui = 'italic', fg = nvim.g.color20})
hi('LspDiagnosticsVirtualTextInfo', {gui = 'italic', fg = nvim.g.color19})
hi('LspDiagnosticsVirtualTextHint', {gui = 'italic', fg = nvim.g.color19})

-- Signify highlights
hi('SignifySignAdd', {bg = 'none'})
hi('SignifySignChange', {bg = 'none'})
hi('SignifySignDelete', {bg = 'none'})
hi('SignifySignChangeDelete', {bg = 'none'})

-- Telescope
hi('TelescopeNormal', {bg = nvim.g.color18})
hi('TelescopeBorder', {fg = nvim.g.color08, bg = nvim.g.color18})
hi('TelescopeMatching', {fg = nvim.g.color06, bg = nvim.g.color18})
cmd('hi link TelescopePreviewNormal TelescopeNormal')
-- cmd('hi TelescopePreviewBorder fg = #000000 bg = nvim.g.color00)

-- Highlighting for floating windows
hi('NormalFloat', {bg = nvim.g.color18})
hi('FloatBorder', {fg = nvim.g.color08, bg = nvim.g.color18})
cmd('hi link CompeDocumentation NormalFloat')
cmd('hi link CompeDocumentationBorder FloatBorder')
