-- Pretty icons
require('nvim-web-devicons').setup { default = true }

-- Setup base16
local nvim = require('nvim')
local base16_theme
if vim.env.BASE16_THEME then
  base16_theme = require('themes.base16-' .. vim.env.BASE16_THEME)
else
  base16_theme = require('themes.base16-decaf')
end
require('theme').apply_base16_theme(base16_theme, true)

-- Setup colorizer
require('colorizer').setup {}

-- Setup diagnostic characters
vim.fn.sign_define('DiagnosticSignError', { text = '▎', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '▎', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '▎', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '▎', texthl = 'DiagnosticSignHint' })

-- Bufferline setup
require('barbar').setup {
  icons = {
    buffer_index = true,
    separator = { left = '▍', right = '' },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = false, icon = 'Ⓧ ' },
      [vim.diagnostic.severity.HINT] = { enabled = false, icon = '💡' },
      [vim.diagnostic.severity.INFO] = { enabled = false, icon = 'ⓘ ' },
      [vim.diagnostic.severity.WARN] = { enabled = false, icon = '⚠️ ' },
    },
    visible = {
      separator = { left = '▍', right = '' },
    },
  },
  maximum_length = 20,
  semantic_letters = false
}

-- Lualine setup
local b = { bg = nvim.g.color19, fg = nvim.g.color07 }
local c = { bg = nvim.g.color18, fg = nvim.g.color08 }
local fg = nvim.g.color00

require('lualine').setup {
  options = {
    theme = {
      normal = { a = { bg = nvim.g.color04, fg = fg, gui = 'bold' }, b = b, c = c },
      insert = { a = { bg = nvim.g.color02, fg = fg, gui = 'bold' }, b = b, c = c },
      visual = { a = { bg = nvim.g.color05, fg = fg, gui = 'bold' }, b = b, c = c },
      replace = { a = { bg = nvim.g.color01, fg = fg, gui = 'bold' }, b = b, c = c },
      command = { a = { bg = nvim.g.color16, fg = fg, gui = 'bold' }, b = b, c = c },
      inactive = { b = { bg = nvim.g.color19, fg = fg, gui = 'bold' }, c = c }
    },
    section_separators = '',
    component_separators = '│'
  },
  sections = {
    lualine_b = { { 'filename', file_status = true } },
    lualine_c = {
      { 'branch', icon = '' }, {
      'diff',
      symbols = { added = ' ', modified = '柳', removed = ' ' },
      color_added = nvim.g.color08,
      color_modified = nvim.g.color08,
      color_removed = nvim.g.color08
    }
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        color_error = nvim.g.color17,
        color_warn = nvim.g.color03,
        color_info = nvim.g.color06,
        color_hint = nvim.g.color08,
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
      }, { 'encoding', upper = true }, 'fileformat'
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
hi('Number', { fg = nvim.g.color17 })
hi('Comment', { gui = 'italic' })
hi('CursorLine', { bg = nvim.g.color18 })
hi('CursorLineNr', { fg = nvim.g.color07, bg = nvim.g.color18 })
hi('LineNr', { fg = nvim.g.color19, bg = 'none' })
hi('SignColumn', { bg = 'none' })
hi('TagbarFoldIcon', { fg = nvim.g.color04 })
hi('VertSplit', { bg = 'none' })

-- Language highlighting
hi('@attribute', { gui = 'italic', fg = nvim.g.color04 })
hi('@keyword', { gui = 'italic', fg = nvim.g.color05 })
hi('@keyword.function', { gui = 'italic', fg = nvim.g.color05 })
hi('@keyword.return', { gui = 'italic', fg = nvim.g.color16 })
hi('@variable', { fg = 'none' })
hi('@exception', { gui = 'bold', fg = nvim.g.color09 })
hi('@constructor', { gui = 'bold', fg = nvim.g.color12 })

-- Popup menu
hi('PmenuSel', { fg = nvim.g.color07, bg = nvim.g.color19 })

-- Custom plugin highlights
hi('Sneak', { fg = 'bg', bg = nvim.g.color17 })
hi('HighlightedYankRegion', { bg = nvim.g.color19 })
hi('IndentBlanklineChar', { fg = nvim.g.color19, bg = 'none' })
hi('IndentBlanklineContextChar', { fg = nvim.g.color08, bg = 'none' })

-- Treesitter highlights
cmd('hi TSPunctBracket guifg = fg')
cmd('hi TSPunctDelimiter guifg = fg')
cmd('hi TSPunctSpecial guifg = fg')
hi('RainbowCol1', { fg = nvim.g.color06 })
hi('RainbowCol2', { fg = nvim.g.color04 })
hi('RainbowCol3', { fg = nvim.g.color03 })
hi('RainbowCol4', { fg = nvim.g.color05 })
hi('RainbowCol5', { fg = nvim.g.color12 })
hi('RainbowCol6', { fg = nvim.g.color11 })
hi('RainbowCol7', { fg = nvim.g.color07 })

-- LSP highlights
hi('LspReferenceRead', { gui = 'bold', bg = nvim.g.color19 })
hi('LspReferenceText', { gui = 'bold', bg = nvim.g.color19 })
hi('LspReferenceWrite', { gui = 'bold', bg = nvim.g.color19 })
hi('DiagnosticSignError', { gui = 'italic', fg = nvim.g.color17 })
hi('DiagnosticSignWarning', { gui = 'italic', fg = nvim.g.color11 })
hi('DiagnosticSignInformation', { gui = 'italic', fg = nvim.g.color10 })
hi('DiagnosticSignHint', { gui = 'italic', fg = nvim.g.color14 })
hi('DiagnosticUnderlineError', { gui = 'undercurl' })
hi('DiagnosticUnderlineWarning', { gui = 'undercurl' })
hi('DiagnosticUnderlineInformation', { gui = 'undercurl' })
hi('DiagnosticUnderlineHint', { gui = 'undercurl' })
hi('DiagnosticVirtualTextError', { gui = 'italic', fg = nvim.g.color17 })
hi('DiagnosticVirtualTextWarning', { gui = 'italic', fg = nvim.g.color20 })
hi('DiagnosticVirtualTextInfo', { gui = 'italic', fg = nvim.g.color19 })
hi('DiagnosticVirtualTextHint', { gui = 'italic', fg = nvim.g.color19 })

-- Signify highlights
hi('SignifySignAdd', { bg = 'none' })
hi('SignifySignChange', { bg = 'none' })
hi('SignifySignDelete', { bg = 'none' })
hi('SignifySignChangeDelete', { bg = 'none' })

-- Highlighting for floating windows
hi('NormalFloat', { bg = 'none' })
hi('FloatBorder', { bg = 'none', fg = nvim.g.color08 })
cmd('hi link CmpDoc NormalFloat')
cmd('hi link CmpBorder FloatBorder')
cmd('hi link CmpDocBorder FloatBorder')
hi('CmpItemKindVariable', { bg = 'none', fg = nvim.g.color06 })
hi('CmpItemKindInterface', { bg = 'none', fg = nvim.g.color06 })
hi('CmpItemKindText', { bg = 'none', fg = nvim.g.color06 })
hi('CmpItemKindFunction', { bg = 'none', fg = nvim.g.color05 })
hi('CmpItemKindMethod', { bg = 'none', fg = nvim.g.color05 })
hi('CmpItemKindKeyword', { bg = 'none', fg = nvim.g.color04 })
hi('CmpItemKindProperty', { bg = 'none', fg = nvim.g.color04 })
hi('CmpItemKindUnit', { bg = 'none', fg = nvim.g.color04 })
hi('CmpItemKindClass', { bg = 'none', fg = nvim.g.color03 })

-- Telescope
cmd('hi link TelescopeNormal NormalFloat')
cmd('hi link TelescopeBorder FloatBorder')
hi('TelescopeMatching', { fg = nvim.g.color06, bg = nvim.g.color18 })
cmd('hi link TelescopePreviewNormal TelescopeNormal')
-- cmd('hi TelescopePreviewBorder fg = #000000 bg = nvim.g.color00)

-- Highlighting for diff
hi('DiffAdd', { gui = 'none', fg = 'none', bg = "#354540" })
hi('DiffChange', { gui = 'none', fg = 'none', bg = "#353550" })
hi('DiffModified', { gui = 'none', fg = 'none', bg = "#353550" })
hi('DiffDelete', { gui = 'none', fg = 'none', bg = "#453540" })
hi('DiffText', { gui = 'none', bg = "#353550" })

-- Barbar (tab/bufferline) highlights
-- Tab/bufferline background
hi('BufferTabpages', { fg = nvim.g.color18 })
hi('BufferTabpageFill', { fg = nvim.g.colorbg, bg = nvim.g.colorbg })
-- Inactive buffers
hi('BufferInactive', { fg = nvim.g.color20, bg = nvim.g.color18 })
hi('BufferInactiveIndex', { fg = nvim.g.color20, bg = nvim.g.color18 })
hi('BufferInactiveMod',
  { gui = 'italic', fg = nvim.g.color17, bg = nvim.g.color18 })
hi('BufferInactiveSign', { fg = nvim.g.colorbg, bg = nvim.g.color18 })
hi('BufferInactiveIcon', { fg = nvim.g.color20, bg = nvim.g.color17 })
hi('BufferInactiveTarget',
  { gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color08 })
-- Currently visible (but not active) buffer(s)
hi('BufferVisible', { fg = nvim.g.color20, bg = nvim.g.color19 })
hi('BufferVisibleIndex', { fg = nvim.g.color20, bg = nvim.g.color19 })
hi('BufferVisibleMod',
  { gui = 'italic', fg = nvim.g.color17, bg = nvim.g.color19 })
hi('BufferVisibleSign', { fg = nvim.g.colorbg, bg = nvim.g.color19 })
hi('BufferVisibleIcon', { fg = nvim.g.color21, bg = nvim.g.color19 })
hi('BufferVisibleTarget',
  { gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color08 })
-- Currently active/selected buffer
hi('BufferCurrent', { fg = nvim.g.color15, bg = nvim.g.color19 })
hi('BufferCurrentIndex', { fg = nvim.g.color15, bg = nvim.g.color19 })
hi('BufferCurrentMod',
  { gui = 'italic,bold', fg = nvim.g.color17, bg = nvim.g.color19 })
hi('BufferCurrentSign', { fg = nvim.g.color04, bg = nvim.g.color19 })
--hi('BufferCurrentIcon', { fg = 'bg', bg = nvim.g.color19 })
hi('BufferCurrentTarget',
  { gui = 'bold', fg = nvim.g.color17, bg = nvim.g.color08 })
