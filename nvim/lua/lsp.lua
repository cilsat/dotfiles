-- LSP config via nvim-lspconfig
local nvim_lsp = require('lspconfig')

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Define custome on_attach function to inject keymaps and other options
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-m>', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<F4>', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Set autocommands conditional on server_capabilities
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Floating windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = border("FloatBorder") })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = border("FloatBorder") })
end

-- Enable snippet and folding support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Use a loop to conveniently both setup all defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "gopls", "jdtls", "phpactor", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

-- Setup Lua completion manually
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.lua_ls.setup {
  cmd = { 'lua-language-server' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = runtime_path },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false }
    }
  }
}

-- Attempt to load python environment automatically when using pyright
local path = require('lspconfig/util').path
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end
  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end
  -- Use virtualenv in .venv in workspace directory if available.
  local match = vim.fn.glob(path.join(workspace, '.venv/bin/python'))
  if match ~= '' then
    return path.join('.venv', 'bin', 'python')
  end
  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

nvim_lsp.pyright.setup {
  on_init = function(client)
    client.config.settings.python.pythonPath =
        get_python_path(client.config.root_dir)
  end,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Setup clangd manually
capabilities.offsetEncoding = { "utf-16" }
nvim_lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Setup rust-tools separately
require('rust-tools').setup {
  server = { on_attach = on_attach }
}

-- LSP completion and snippets via nvim-cmp and luasnip
local cmp_window = require("cmp.utils.window")
cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
      vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
      :match("%s") == nil
end

require('luasnip.loaders.from_vscode').lazy_load()
local cmp = require('cmp')
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, { { name = 'buffer' } }
  )
})
local luasnip = require('luasnip')
local lspkind = require('lspkind')
cmp.setup {
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
    },
    documentation = {
      border = border("CmpDocBorder")
    }
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      menu = {
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        luasnip = "[SNIP]",
        nvim_lua = "[LUA]",
        latex_symbols = "[TEX]"
      }
    })
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' })
  },
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'treesitter' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip',                option = { show_autosnippets = true } },
  }
}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- LSP diagnostics, formatting, and code actions via null-ls
local null_ls = require("null-ls")
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.hadolint,
    --null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.phpcs,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    --null_ls.builtins.formatting.phpcbf,
    null_ls.builtins.formatting.pg_format,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.ruff,
    null_ls.builtins.formatting.shfmt,
    --null_ls.builtins.formatting.stylua,
  }
}

-- Source code syntax highlighting/parsing via nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash", "c", "cmake", "cpp", "dockerfile", "erlang", "elixir", "go",
    "html", "java", "javascript", "json", "julia", "kotlin", "latex", "lua",
    "markdown", "markdown_inline", "perl", "php", "proto", "python",
    "qmljs", "query", "ruby", "rust", "toml", "tsx", "typescript", "vue",
    "yaml"
  },
  sync_install = false,
  autopairs = { enable = true },
  highlight = { enable = true },
  indent = { enable = false },
  rainbow = { enable = true, extended_mode = true },
  --playground = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@call.outer',
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        --['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        ['ic'] = 'call.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ap'] = '@parameter.outer',
        ['ip'] = '@parameter.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Search and filter various sources via telescope
local picker_config = {
  prompt_title = '',
  results_title = '',
  preview_title = '',
  find_command = {
    'fd', '-i', '-uu', '-F', '-L', '--color=never'
  },
}
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ["<C-w>"] = function() vim.cmd [[normal! bcw]] end,
      }
    },
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    winblend = 7,
    layout_strategy = 'flex',
    layout_config = { height = 0.7 },
    --dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg', '--column', '-H', '-F', '-L', '-S'
    },
    file_ignore_patterns = {
      '.git/.*',
      '.mypy_cache',
      'node_modules',
      '__pycache__',
      '*.chunk.js',
      '*.o'
    }
  },
  pickers = {
    find_files = picker_config,
    live_grep = picker_config,
    buffers = picker_config,
    help_tags = picker_config,
    commands = picker_config,
    lsp_references = picker_config,
    current_buffer_fuzzy_find = picker_config,
    filte_browser = picker_config
  },
}
require('telescope').load_extension('fzf')

-- Indent lines
require('ibl').setup {
  indent = { char = '▏' },
  exclude = {
    filetypes = { 'help', 'vim' },
    buftypes = { 'terminal', 'popup' },
  }
}

-- Load autopairs
require('nvim-autopairs').setup {
  check_ts = true,
  map_c_w = true,
}
-- Modern folding
require('ufo').setup()
-- Git diff, file history, and conflicts
require('diffview').setup {
  enhanced_diff_hl = true,
}
-- Add/delete/change surrounding pairs
require('nvim-surround').setup()
-- Progress bar for LSP operations
--require('fidget').setup {}
-- Buffer navigation in 3-4 keystrokes
require('leap').add_default_mappings()
-- Setup Octo
require('octo').setup()
