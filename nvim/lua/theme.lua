local nvim = require 'nvim'
local M = {}

local function highlight(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
	local parts = {group}
	if guifg then table.insert(parts, "guifg=#"..guifg) end
	if guibg then table.insert(parts, "guibg=#"..guibg) end
	if ctermfg then table.insert(parts, "ctermfg="..ctermfg) end
	if ctermbg then table.insert(parts, "ctermbg="..ctermbg) end
	if attr then
		table.insert(parts, "gui="..attr)
		table.insert(parts, "cterm="..attr)
	end
	if guisp then table.insert(parts, "guisp=#"..guisp) end

	-- nvim.ex.highlight(parts)
	vim.api.nvim_command('highlight '..table.concat(parts, ' '))
end

-- Modified from https://github.com/chriskempson/base16-vim
function M.apply_base16_theme(theme, use_256_colorspace)
	-- Terminal color definitions
	local cterm00        = "00"
	local cterm03        = "08"
	local cterm05        = "07"
	local cterm07        = "15"
	local cterm08        = "01"
	local cterm0A        = "03"
	local cterm0B        = "02"
	local cterm0C        = "06"
	local cterm0D        = "04"
	local cterm0E        = "05"

	local cterm01, cterm02, cterm04, cterm06, cterm09, cterm0F

	if use_256_colorspace then
		cterm01 = "18"
		cterm02 = "19"
		cterm04 = "20"
		cterm06 = "21"
		cterm09 = "16"
		cterm0F = "17"
	else
		cterm01 = "10"
		cterm02 = "11"
		cterm04 = "12"
		cterm06 = "13"
		cterm09 = "09"
		cterm0F = "14"
	end

	-- Neovim terminal colours
	if nvim.fn.has("nvim") then
		nvim.g.color00 = "#"..theme.base00
		nvim.g.color01 = "#"..theme.base08
		nvim.g.color02 = "#"..theme.base0B
		nvim.g.color03 = "#"..theme.base0A
		nvim.g.color04 = "#"..theme.base0D
		nvim.g.color05 = "#"..theme.base0E
		nvim.g.color06 = "#"..theme.base0C
		nvim.g.color07 = "#"..theme.base05
		nvim.g.color08 = "#"..theme.base03
		nvim.g.color09 = "#"..theme.base08
		nvim.g.color10 = "#"..theme.base0B
		nvim.g.color11 = "#"..theme.base0A
		nvim.g.color12 = "#"..theme.base0D
		nvim.g.color13 = "#"..theme.base0E
		nvim.g.color14 = "#"..theme.base0C
		nvim.g.color15 = "#"..theme.base07
    nvim.g.color16 = "#"..theme.base09
    nvim.g.color17 = "#"..theme.base0F
    nvim.g.color18 = "#"..theme.base01
    nvim.g.color19 = "#"..theme.base02
    nvim.g.color20 = "#"..theme.base04
    nvim.g.color21 = "#"..theme.base06

		if nvim.o.background == "light" then
			nvim.g.terminal_color_background = "#"..theme.base05
			nvim.g.terminal_color_foreground = "#"..theme.base0B
		else
			nvim.g.terminal_color_background = "#"..theme.base00
			nvim.g.terminal_color_foreground = "#"..theme.base0E
		end
    nvim.g.colorbg = nvim.g.terminal_color_background
    nvim.g.colorfg = nvim.g.terminal_color_foreground

	-- VIM, not NVIM settings
	-- elseif nvim.fn.has("terminal") then
	-- 	nvim.g.terminal_ansi_colors = {
	-- 		theme.base00,
	-- 		theme.base08,
	-- 		theme.base0B,
	-- 		theme.base0A,
	-- 		theme.base0D,
	-- 		theme.base0E,
	-- 		theme.base0C,
	-- 		theme.base05,
	-- 		theme.base03,
	-- 		theme.base08,
	-- 		theme.base0B,
	-- 		theme.base0A,
	-- 		theme.base0D,
	-- 		theme.base0E,
	-- 		theme.base0C,
	-- 		theme.base07,
	-- 	}
	end

	-- TODO
	-- nvim.command "hi clear"
	-- nvim.command "syntax reset"

	-- Vim editor colors
	highlight("Normal",        theme.base05, theme.base00, cterm05, cterm00, nil, nil)
	highlight("Bold",          nil, nil, nil, nil, "bold", nil)
	highlight("Debug",         theme.base08, nil, cterm08, nil, nil, nil)
	highlight("Directory",     theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("Error",         theme.base00, theme.base08, cterm00, cterm08, nil, nil)
	highlight("ErrorMsg",      theme.base08, theme.base00, cterm08, cterm00, nil, nil)
	highlight("Exception",     theme.base08, nil, cterm08, nil, nil, nil)
	highlight("FoldColumn",    theme.base0C, theme.base01, cterm0C, cterm01, nil, nil)
	highlight("Folded",        theme.base03, theme.base01, cterm03, cterm01, nil, nil)
	highlight("IncSearch",     theme.base01, theme.base09, cterm01, cterm09, "none", nil)
	highlight("Italic",        nil, nil, nil, nil, "none", nil)
	highlight("Macro",         theme.base08, nil, cterm08, nil, nil, nil)
	highlight("MatchParen",    nil, theme.base03, nil, cterm03,  nil, nil)
	highlight("ModeMsg",       theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("MoreMsg",       theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("Question",      theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("Search",        theme.base01, theme.base0A, cterm01, cterm0A,  nil, nil)
	highlight("Substitute",    theme.base01, theme.base0A, cterm01, cterm0A, "none", nil)
	highlight("SpecialKey",    theme.base03, nil, cterm03, nil, nil, nil)
	highlight("TooLong",       theme.base08, nil, cterm08, nil, nil, nil)
	highlight("Underlined",    theme.base08, nil, cterm08, nil, nil, nil)
	highlight("Visual",        nil, theme.base02, nil, cterm02, nil, nil)
	highlight("VisualNOS",     theme.base08, nil, cterm08, nil, nil, nil)
	highlight("WarningMsg",    theme.base08, nil, cterm08, nil, nil, nil)
	highlight("WildMenu",      theme.base08, theme.base0A, cterm08, nil, nil, nil)
	highlight("Title",         theme.base0D, nil, cterm0D, nil, "none", nil)
	highlight("Conceal",       theme.base0D, theme.base00, cterm0D, cterm00, nil, nil)
	highlight("Cursor",        theme.base00, theme.base05, cterm00, cterm05, nil, nil)
	highlight("NonText",       theme.base03, nil, cterm03, nil, nil, nil)
	highlight("LineNr",        theme.base03, theme.base01, cterm03, cterm01, nil, nil)
	highlight("SignColumn",    theme.base03, theme.base01, cterm03, cterm01, nil, nil)
	highlight("StatusLine",    theme.base04, theme.base02, cterm04, cterm02, "none", nil)
	highlight("StatusLineNC",  theme.base03, theme.base01, cterm03, cterm01, "none", nil)
	highlight("VertSplit",     theme.base02, theme.base02, cterm02, cterm02, "none", nil)
	highlight("ColorColumn",   nil, theme.base01, nil, cterm01, "none", nil)
	highlight("CursorColumn",  nil, theme.base01, nil, cterm01, "none", nil)
	highlight("CursorLine",    nil, theme.base01, nil, cterm01, "none", nil)
	highlight("CursorLineNr",  theme.base04, theme.base01, cterm04, cterm01, nil, nil)
	highlight("QuickFixLine",  nil, theme.base01, nil, cterm01, "none", nil)
	highlight("PMenu",         theme.base05, theme.base01, cterm05, cterm01, "none", nil)
	highlight("PMenuSel",      theme.base01, theme.base05, cterm01, cterm05, nil, nil)
	highlight("TabLine",       theme.base03, theme.base01, cterm03, cterm01, "none", nil)
	highlight("TabLineFill",   theme.base03, theme.base01, cterm03, cterm01, "none", nil)
	highlight("TabLineSel",    theme.base0B, theme.base01, cterm0B, cterm01, "none", nil)

	-- Standard syntax highlighting
	highlight("Boolean",      theme.base09, nil, cterm09, nil, nil, nil)
	highlight("Character",    theme.base08, nil, cterm08, nil, nil, nil)
	highlight("Comment",      theme.base03, nil, cterm03, nil, nil, nil)
	highlight("Conditional",  theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("Constant",     theme.base09, nil, cterm09, nil, nil, nil)
	highlight("Define",       theme.base0E, nil, cterm0E, nil, "none", nil)
	highlight("Delimiter",    theme.base0F, nil, cterm0F, nil, nil, nil)
	highlight("Float",        theme.base09, nil, cterm09, nil, nil, nil)
	highlight("Function",     theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("Identifier",   theme.base08, nil, cterm08, nil, "none", nil)
	highlight("Include",      theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("Keyword",      theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("Label",        theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("Number",       theme.base09, nil, cterm09, nil, nil, nil)
	highlight("Operator",     theme.base05, nil, cterm05, nil, "none", nil)
	highlight("PreProc",      theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("Repeat",       theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("Special",      theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("SpecialChar",  theme.base0F, nil, cterm0F, nil, nil, nil)
	highlight("Statement",    theme.base08, nil, cterm08, nil, nil, nil)
	highlight("StorageClass", theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("String",       theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("Structure",    theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("Tag",          theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("Todo",         theme.base0A, theme.base01, cterm0A, cterm01, nil, nil)
	highlight("Type",         theme.base0A, nil, cterm0A, nil, "none", nil)
	highlight("Typedef",      theme.base0A, nil, cterm0A, nil, nil, nil)

	---
	-- Extra definitions
	---

	-- C highlighting
	highlight("cOperator",   theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("cPreCondit",  theme.base0E, nil, cterm0E, nil, nil, nil)

	-- C# highlighting
	highlight("csClass",                 theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("csAttribute",             theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("csModifier",              theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("csType",                  theme.base08, nil, cterm08, nil, nil, nil)
	highlight("csUnspecifiedStatement",  theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("csContextualStatement",   theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("csNewDecleration",        theme.base08, nil, cterm08, nil, nil, nil)

	-- CSS highlighting
	highlight("cssBraces",      theme.base05, nil, cterm05, nil, nil, nil)
	highlight("cssClassName",   theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("cssColor",       theme.base0C, nil, cterm0C, nil, nil, nil)

	-- Diff highlighting
	highlight("DiffAdd",      theme.base0B, theme.base01,  cterm0B, cterm01, nil, nil)
	highlight("DiffChange",   theme.base03, theme.base01,  cterm03, cterm01, nil, nil)
	highlight("DiffDelete",   theme.base08, theme.base01,  cterm08, cterm01, nil, nil)
	highlight("DiffText",     theme.base0D, theme.base01,  cterm0D, cterm01, nil, nil)
	highlight("DiffAdded",    theme.base0B, theme.base00,  cterm0B, cterm00, nil, nil)
	highlight("DiffFile",     theme.base08, theme.base00,  cterm08, cterm00, nil, nil)
	highlight("DiffNewFile",  theme.base0B, theme.base00,  cterm0B, cterm00, nil, nil)
	highlight("DiffLine",     theme.base0D, theme.base00,  cterm0D, cterm00, nil, nil)
	highlight("DiffRemoved",  theme.base08, theme.base00,  cterm08, cterm00, nil, nil)

	-- Git highlighting
	highlight("gitcommitOverflow",       theme.base08, nil, cterm08, nil, nil, nil)
	highlight("gitcommitSummary",        theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("gitcommitComment",        theme.base03, nil, cterm03, nil, nil, nil)
	highlight("gitcommitUntracked",      theme.base03, nil, cterm03, nil, nil, nil)
	highlight("gitcommitDiscarded",      theme.base03, nil, cterm03, nil, nil, nil)
	highlight("gitcommitSelected",       theme.base03, nil, cterm03, nil, nil, nil)
	highlight("gitcommitHeader",         theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("gitcommitSelectedType",   theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("gitcommitUnmergedType",   theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("gitcommitDiscardedType",  theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("gitcommitBranch",         theme.base09, nil, cterm09, nil, "bold", nil)
	highlight("gitcommitUntrackedFile",  theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("gitcommitUnmergedFile",   theme.base08, nil, cterm08, nil, "bold", nil)
	highlight("gitcommitDiscardedFile",  theme.base08, nil, cterm08, nil, "bold", nil)
	highlight("gitcommitSelectedFile",   theme.base0B, nil, cterm0B, nil, "bold", nil)

	-- GitGutter highlighting
	highlight("GitGutterAdd",     theme.base0B, theme.base01, cterm0B, cterm01, nil, nil)
	highlight("GitGutterChange",  theme.base0D, theme.base01, cterm0D, cterm01, nil, nil)
	highlight("GitGutterDelete",  theme.base08, theme.base01, cterm08, cterm01, nil, nil)
	highlight("GitGutterChangeDelete",  theme.base0E, theme.base01, cterm0E, cterm01, nil, nil)

	-- HTML highlighting
	highlight("htmlBold",    theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("htmlItalic",  theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("htmlEndTag",  theme.base05, nil, cterm05, nil, nil, nil)
	highlight("htmlTag",     theme.base05, nil, cterm05, nil, nil, nil)

	-- JavaScript highlighting
	highlight("javaScript",        theme.base05, nil, cterm05, nil, nil, nil)
	highlight("javaScriptBraces",  theme.base05, nil, cterm05, nil, nil, nil)
	highlight("javaScriptNumber",  theme.base09, nil, cterm09, nil, nil, nil)
	-- pangloss/vim-javascript highlighting
	highlight("jsOperator",          theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("jsStatement",         theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("jsReturn",            theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("jsThis",              theme.base08, nil, cterm08, nil, nil, nil)
	highlight("jsClassDefinition",   theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("jsFunction",          theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("jsFuncName",          theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("jsFuncCall",          theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("jsClassFuncName",     theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("jsClassMethodType",   theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("jsRegexpString",      theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("jsGlobalObjects",     theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("jsGlobalNodeObjects", theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("jsExceptions",        theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("jsBuiltins",          theme.base0A, nil, cterm0A, nil, nil, nil)

	-- Mail highlighting
	highlight("mailQuoted1",  theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("mailQuoted2",  theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("mailQuoted3",  theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("mailQuoted4",  theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("mailQuoted5",  theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("mailQuoted6",  theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("mailURL",      theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("mailEmail",    theme.base0D, nil, cterm0D, nil, nil, nil)

	-- Markdown highlighting
	highlight("markdownCode",              theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("markdownError",             theme.base05, theme.base00, cterm05, cterm00, nil, nil)
	highlight("markdownCodeBlock",         theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("markdownHeadingDelimiter",  theme.base0D, nil, cterm0D, nil, nil, nil)

	-- NERDTree highlighting
	highlight("NERDTreeDirSlash",  theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("NERDTreeExecFile",  theme.base05, nil, cterm05, nil, nil, nil)

	-- PHP highlighting
	highlight("phpMemberSelector",  theme.base05, nil, cterm05, nil, nil, nil)
	highlight("phpComparison",      theme.base05, nil, cterm05, nil, nil, nil)
	highlight("phpParent",          theme.base05, nil, cterm05, nil, nil, nil)
	highlight("phpMethodsVar",      theme.base0C, nil, cterm0C, nil, nil, nil)

	-- Python highlighting
	highlight("pythonOperator",  theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("pythonRepeat",    theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("pythonInclude",   theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("pythonStatement", theme.base0E, nil, cterm0E, nil, nil, nil)

	-- Ruby highlighting
	highlight("rubyAttribute",               theme.base0D, nil, cterm0D, nil, nil, nil)
	highlight("rubyConstant",                theme.base0A, nil, cterm0A, nil, nil, nil)
	highlight("rubyInterpolationDelimiter",  theme.base0F, nil, cterm0F, nil, nil, nil)
	highlight("rubyRegexp",                  theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("rubySymbol",                  theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("rubyStringDelimiter",         theme.base0B, nil, cterm0B, nil, nil, nil)

	-- SASS highlighting
	highlight("sassidChar",     theme.base08, nil, cterm08, nil, nil, nil)
	highlight("sassClassChar",  theme.base09, nil, cterm09, nil, nil, nil)
	highlight("sassInclude",    theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("sassMixing",     theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("sassMixinName",  theme.base0D, nil, cterm0D, nil, nil, nil)

	-- Signify highlighting
	highlight("SignifySignAdd",     theme.base0B, theme.base01, cterm0B, cterm01, nil, nil)
	highlight("SignifySignChange",  theme.base0D, theme.base01, cterm0D, cterm01, nil, nil)
	highlight("SignifySignDelete",  theme.base08, theme.base01, cterm08, cterm01, nil, nil)

	-- Spelling highlighting
	highlight("SpellBad",     nil, nil, nil, nil, "undercurl", theme.base08)
	highlight("SpellLocal",   nil, nil, nil, nil, "undercurl", theme.base0C)
	highlight("SpellCap",     nil, nil, nil, nil, "undercurl", theme.base0D)
	highlight("SpellRare",    nil, nil, nil, nil, "undercurl", theme.base0E)

	-- Startify highlighting
	highlight("StartifyBracket",  theme.base03, nil, cterm03, nil, nil, nil)
	highlight("StartifyFile",     theme.base07, nil, cterm07, nil, nil, nil)
	highlight("StartifyFooter",   theme.base03, nil, cterm03, nil, nil, nil)
	highlight("StartifyHeader",   theme.base0B, nil, cterm0B, nil, nil, nil)
	highlight("StartifyNumber",   theme.base09, nil, cterm09, nil, nil, nil)
	highlight("StartifyPath",     theme.base03, nil, cterm03, nil, nil, nil)
	highlight("StartifySection",  theme.base0E, nil, cterm0E, nil, nil, nil)
	highlight("StartifySelect",   theme.base0C, nil, cterm0C, nil, nil, nil)
	highlight("StartifySlash",    theme.base03, nil, cterm03, nil, nil, nil)
	highlight("StartifySpecial",  theme.base03, nil, cterm03, nil, nil, nil)

	-- Java highlighting
	highlight("javaOperator",     theme.base0D, nil, cterm0D, nil, nil, nil)

  -- Treesitter
  highlight('TSNone',               theme.base05, theme.base00, cterm05, cterm00, nil, nil)
  highlight('TSPunctDelimiter',     theme.base07, nil, cterm07, nil, nil, nil)
  highlight('TSPunctBracket',       theme.base07, nil, cterm07, nil, nil, nil)
  highlight('TSPunctSpecial',       theme.base0F, nil, cterm0F, nil, nil, nil)
  highlight('TSConstant',           theme.base09, nil, cterm0B, nil, "bold", nil)
  highlight('TSConstBuiltin',       theme.base0C, nil, cterm0C, nil, nil, nil)
  highlight('TSConstMacro',         theme.base0E, nil, cterm0E, nil, "none", nil)
  highlight('TSString',             theme.base0B, nil, cterm0B, nil, nil, nil)
  highlight('TSStringRegex',        theme.base0B, nil, cterm0B, nil, nil, nil)
  highlight('TSStringEscape',       theme.base0F, nil, cterm0F, nil, nil, nil)
  highlight('TSCharacter',          theme.base08, nil, cterm08, nil, nil, nil)
  highlight('TSNumber',             theme.base0B, nil, cterm0B, nil, nil, nil)
  highlight('TSBoolean',            theme.base0B, nil, cterm0B, nil, "bold", nil)
  highlight('TSFloat',              theme.base0B, nil, cterm0B, nil, nil, nil)
  highlight('TSFunction',           theme.base0D, nil, cterm0D, nil, "bold", nil)
  highlight('TSFuncBuiltin',        theme.base0C, nil, cterm0C, nil, nil, nil)
  highlight('TSFuncMacro',          theme.base08, nil, cterm08, nil, nil, nil)
  highlight('TSParameter',          theme.base08, nil, cterm08, nil, "none", nil)
  highlight('TSParameterReference', theme.base08, nil, cterm08, nil, "none", nil)
  highlight('TSMethod',             theme.base0D, nil, cterm0D, nil, "bold", nil)
  highlight('TSField',              theme.base0A, nil, cterm0A, nil, "none", nil)
  highlight('TSProperty',           theme.base08, nil, cterm08, nil, "none", nil)
  highlight('TSConstructor',        theme.base0C, nil, cterm0C, nil, nil, nil)
  highlight('TSAnnotation',         theme.base0A, nil, cterm0A, nil, nil, nil)
  highlight('TSAttribute',          theme.base0A, nil, cterm0A, nil, nil, nil)
  highlight('TSNamespace',          theme.base0D, nil, cterm0D, nil, nil, nil)
  highlight('TSConditional',        theme.base0E, nil, cterm0E, nil, nil, nil)
  highlight('TSRepeat',             theme.base0A, nil, cterm0A, nil, nil, nil)
  highlight('TSLabel',              theme.base0A, nil, cterm0A, nil, nil, nil)
  highlight('TSOperator',           theme.base07, nil, cterm07, nil, "none", nil)
  highlight('TSKeyword',            theme.base0E, nil, cterm0E, nil, nil, nil)
  highlight('TSKeywordFunction',    theme.base0E, nil, cterm0E, nil, "bold", nil)
  highlight('TSKeywordOperator',    theme.base05, nil, cterm05, nil, "none", nil)
  highlight('TSException',          theme.base08, nil, cterm08, nil, nil, nil)
  highlight('TSType',               theme.base0A, nil, cterm0A, nil, "bold", nil)
  highlight('TSTypeBuiltin',        theme.base0A, nil, cterm0A, nil, "bold", nil)
  highlight('TSInclude',            theme.base0D, nil, cterm0D, nil, nil, nil)
  highlight('TSVariableBuiltin',    theme.base0C, nil, cterm0C, nil, nil, nil)
  highlight('TSText',               theme.base05, theme.base00, cterm05, cterm00, nil, nil)
  highlight('TSStrong',             theme.base07, theme.base00, cterm07, cterm00, "bold", nil)
  highlight('TSEmphasis',           theme.base06, theme.base00, cterm06, cterm00, "italic", nil)
  highlight('TSUnderline',          theme.base05, theme.base00, cterm05, cterm00, "underline", nil)
  highlight('TSTitle',              theme.base0D, nil, cterm0D, nil, "none", nil)
  highlight('TSLiteral',            theme.base0B, nil, cterm0B, nil, nil, nil)
  highlight('TSURI',                theme.base08, nil, cterm08, nil, nil, nil)
  highlight('TSTag',                theme.base0A, nil, cterm0A, nil, nil, nil)
  highlight('TSTagDelimiter',       theme.base0F, nil, cterm0F, nil, nil, nil)
  highlight('TSDefinitionUsage',    nil, theme.base02, nil, cterm02, nil, nil)
  highlight('TSDefinition',         theme.base01, theme.base0A, cterm01, cterm0A,  nil, nil)
  highlight('TSCurrentScope',       nil, theme.base01, nil, cterm01, "none", nil)

	-- TODO
	-- nvim.command 'syntax on'
end

return M
