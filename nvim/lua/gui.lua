-- Pretty icons
require'nvim-web-devicons'.setup {
  default = true;
}

-- Setup base16
local nvim = require'nvim'
local theme = require('themes.base16-decaf')
require('theme').apply_base16_theme(theme, true)

-- Setup colorizer
require'colorizer'.setup()

-- Rainbow parentheses
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true,
  }
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
      command = {a = {bg = nvim.g.color16, fg = fg, gui = 'bold'} ,b = b, c = c},
      inactive = {b = {bg = nvim.g.color19, fg = fg, gui = 'bold'}, c = c}
    },
    section_separators = '',
    component_separators = '│',
  },
  sections = {
    lualine_b = {
      {'filename', file_status = true},
      {'filetype', colored = true},
    },
    lualine_c = {
      {'branch', icon = ''},
      {
        'diff',
        symbols = {added = ' ', modified = '柳', removed = ' '},
        color_added = nvim.g.color08,
        color_modified = nvim.g.color08,
        color_removed = nvim.g.color08,
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
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
      },
      {'encoding', upper = true}, 'fileformat'
    }
  }
}

-- Custom editor highlight settings
local cmd = vim.cmd
cmd('hi Number guifg='..nvim.g.color17)
cmd('hi Comment gui=italic')
cmd('hi CursorLine guibg='..nvim.g.color18)
cmd('hi CursorLineNr gui=bold guifg='..nvim.g.color16..' guibg='..nvim.g.color18)
cmd('hi LineNr guifg='..nvim.g.color19..' guibg=none')
cmd('hi TagbarFoldIcon guifg='..nvim.g.color04)

-- Custom plugin highlights
cmd('hi Sneak guifg=bg guibg='..nvim.g.color17)
cmd('hi HighlightedYankRegion guibg='..nvim.g.color19)
cmd('hi IndentBlanklineChar guifg='..nvim.g.color19..' guibg=none')
cmd('hi IndentBlanklineContextChar guifg='..nvim.g.color08..' guibg=none')
cmd('hi LspSagaHoverBorder guifg='..nvim.g.color19)

-- Barbar (tab/bufferline) highlights
-- Currently active/selected buffer
cmd('hi BufferCurrent gui=bold guifg='..nvim.g.color15..' guibg='..nvim.g.color08)
cmd('hi BufferCurrentIndex guifg='..nvim.g.color15..' guibg='..nvim.g.color08)
cmd('hi BufferCurrentMod gui=italic,bold guifg='..nvim.g.color17..' guibg='..nvim.g.color08)
cmd('hi BufferCurrentSign guifg='..nvim.g.color04..' guibg='..nvim.g.color08)
cmd('hi BufferCurrentIcon guifg=bg guibg='..nvim.g.color04)
cmd('hi BufferCurrentTarget gui=bold guifg='..nvim.g.color17..' guibg='..nvim.g.color08)
-- Currently visible (but not active) buffer(s)
cmd('hi BufferVisible gui=bold guifg='..nvim.g.color21..' guibg='..nvim.g.color19)
cmd('hi BufferVisibleIndex guifg='..nvim.g.color21..' guibg='..nvim.g.color19)
cmd('hi BufferVisibleMod gui=italic,bold guifg='..nvim.g.color21..' guibg='..nvim.g.color19)
cmd('hi BufferVisibleSign guifg='..nvim.g.colorbg..' guibg='..nvim.g.color19)
cmd('hi BufferVisibleIcon guifg='..nvim.g.color21..' guibg='..nvim.g.color19)
cmd('hi BufferVisibleTarget gui=bold guifg='..nvim.g.color17..' guibg='..nvim.g.color19)
-- Inactive buffers
cmd('hi BufferInactive guifg='..nvim.g.color20..' guibg='..nvim.g.color18)
cmd('hi BufferInactiveIndex guifg='..nvim.g.color20..' guibg='..nvim.g.color18)
cmd('hi BufferInactiveMod gui=italic guifg='..nvim.g.color20..' guibg='..nvim.g.color18)
cmd('hi BufferInactiveSign guifg='..nvim.g.colorbg..' guibg='..nvim.g.color18)
cmd('hi BufferInactiveIcon guifg='..nvim.g.color20..' guibg='..nvim.g.color17)
cmd('hi BufferInactiveTarget gui=bold guifg='..nvim.g.color17..' guibg='..nvim.g.color18)
-- Tab/bufferline background
cmd('hi BufferTabpages guifg='..nvim.g.color18)
cmd('hi BufferTabpageFill guifg='..nvim.g.colorbg..' guibg=none')

-- Treesitter highlights
cmd('hi TSPunctBracket guifg=fg')
cmd('hi TSPunctDelimiter guifg=fg')
cmd('hi TSPunctSpecial guifg=fg')
cmd('hi RainbowCol1 guifg='..nvim.g.color06)
cmd('hi RainbowCol2 guifg='..nvim.g.color04)
cmd('hi RainbowCol3 guifg='..nvim.g.color03)
cmd('hi RainbowCol4 guifg='..nvim.g.color05)
cmd('hi RainbowCol5 guifg='..nvim.g.color12)
cmd('hi RainbowCol6 guifg='..nvim.g.color11)
cmd('hi RainbowCol7 guifg='..nvim.g.color07)

-- LSP highlights
cmd('hi LspDiagnosticsSignError gui=italic guifg='..nvim.g.color17)
cmd('hi LspDiagnosticsSignWarning gui=italic guifg='..nvim.g.color11)
cmd('hi LspDiagnosticsSignInformation gui=italic guifg='..nvim.g.color10)
cmd('hi LspDiagnosticsSignHint gui=italic guifg='..nvim.g.color14)
cmd('hi LspReferenceRead gui=bold guibg='..nvim.g.color19)
cmd('hi LspReferenceText gui=bold guibg='..nvim.g.color19)
cmd('hi LspReferenceWrite gui=bold guibg='..nvim.g.color19)
cmd('hi LspDiagnosticsUnderlineError gui=undercurl')
cmd('hi LspDiagnosticsUnderlineWarning gui=undercurl')
cmd('hi LspDiagnosticsUnderlineInformation gui=undercurl')
cmd('hi LspDiagnosticsUnderlineHint gui=undercurl')
cmd('hi LspDiagnosticsVirtualTextError gui=italic guifg='..nvim.g.color17)
cmd('hi LspDiagnosticsVirtualTextWarning gui=italic guifg='..nvim.g.color20)
cmd('hi LspDiagnosticsVirtualTextInfo gui=italic guifg='..nvim.g.color19)
cmd('hi LspDiagnosticsVirtualTextHint gui=italic guifg='..nvim.g.color19)

-- Telescope
cmd('hi TelescopeNormal guibg='..nvim.g.color18)
cmd('hi TelescopeBorder guifg=#000000 guibg='..nvim.g.color18)
cmd('hi link TelescopePreviewNormal TelescopeNormal')
-- cmd('hi TelescopePreviewBorder guifg=#000000 guibg='..nvim.g.color00)

-- Highlighting for floating windows
cmd('hi NormalFloat guibg='..nvim.g.color18)
cmd('hi FloatBorder guifg=#000000 guibg='..nvim.g.color18)
cmd('hi link CompeDocumentation NormalFloat')
cmd('hi link CompeDocumentationBorder FloatBorder')
