-- Organizes imports: Useful for gopls
function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params,
                                          wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
  vim.lsp.buf.formatting()
end

-- General LSP Config
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = {noremap = true, silent = true}
  set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  set_keymap('n', '<leader>m', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  set_keymap('n', '<F7>', '<cmd>lua org_imports(250)<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<M-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<M-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.fn.sign_define('DiagnosticSignError',
                       {text = '▎', texthl = 'DiagnosticSignError'})
    vim.fn.sign_define('DiagnosticSignWarn',
                       {text = '▎', texthl = 'DiagnosticSignWarn'})
    vim.fn.sign_define('DiagnosticSignInfo',
                       {text = '▎', texthl = 'DiagnosticSignInfo'})
    vim.fn.sign_define('DiagnosticSignHint',
                       {text = '▎', texthl = 'DiagnosticSignHint'})

    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  local border = {
    {"🭽", "FloatBorder"}, {"▔", "FloatBorder"}, {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"}, {"🭿", "FloatBorder"}, {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"}, {"▏", "FloatBorder"}
  }
  -- Floating windows
  vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {border = border})
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                                                       vim.lsp.handlers.hover,
                                                       {border = border})
end

-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {'documentation', 'detail', 'additionalTextEdits'}
}

-- Use a loop to conveniently both setup all defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {"clangd", "gopls", "jdtls", "phpactor", "rust_analyzer"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup ({on_attach = on_attach, capabilities = capabilities})
end

-- Setup clangd manually
local clangd_caps = vim.lsp.protocol.make_client_capabilities()
clangd_caps.offsetEncoding = {"utf-16"}
nvim_lsp.clangd.setup { capabilities = clangd_caps}

-- Setup Lua completion manually
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  cmd = {'lua-language-server'},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = runtime_path},
      diagnostics = {globals = {'vim'}},
      workspace = {library = vim.api.nvim_get_runtime_file("", true)},
      telemetry = {enable = false}
    }
  }
}

-- Setup typescript-language-server with ts-utils
nvim_lsp.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    require('nvim-lsp-ts-utils').setup {}
    on_attach(client)
  end,
  capabilities = capabilities
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

-- LSP completion config via nvim-cmp
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
                 :match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                        mode, true)
end

local cmp = require('cmp')
cmp.setup {
  window = {
    documentation = {
      border = {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}
    }
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind =
          require('lspkind').presets.default[vim_item.kind] .. " " ..
              vim_item.kind
      vim_item.menu = ({
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        vsnip = "[SNIP]",
        nvim_lua = "[LUA]",
        latex_symbols = "[TEX]"
      })[entry.source.name]
      return vim_item
    end
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available']() == 1 then
        feedkey('<Plug>vsnip-expand-or-jump', '')
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey('<Plug>vsnip-jump-prev', '')
      end
    end, {'i', 's'})
  },
  snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
  sources = {
    {name = 'nvim_lsp'},
    {name = 'treesitter'},
    {name = 'buffer'},
    {name = 'path'},
  }
}

-- Use null-fs for formatting, diagnostics, code actions, etc
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.diagnostics.hadolint,
    --null_ls.builtins.diagnostics.markdownlint,
  }
})

-- Load autopairs
require('nvim-autopairs').setup({
  check_ts = true,
  map_c_w = true,
  fast_wrap = {}
})

-- nvim-treesitter for vastly improved source code parsing
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "c", "cpp", "go", "java", "javascript", "json", "julia", "kotlin",
    "lua", "php", "python", "query", "ruby", "rust", "toml", "typescript", "vue"
  },
  highlight = {enable = true},
  indent = {enable = false},
  rainbow = {enable = true},
  -- autopairs = {enable = true},
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
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
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

-- telescope for fuzzy searching
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
    borderchars = {
      results = {'▔', '▕', '▁', '▏', '🭽', '🭾', '🭿', '🭼'},
      prompt = {' ', '▕', '▁', '▏', '▏', '▕', '🭿', '🭼'},
      preview = {'▔', '▕', '▁', '▏', '🭽', '🭾', '🭿', '🭼'}
    },
    winblend = 7,
    layout_strategy = 'flex',
    layout_config = {height = 0.7},
    --dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg', '--column', '-H', '-uu', '-F', '-L', '-S'
    },
    file_ignore_patterns = {
      '.git/.*',
      '.mypy_cache',
      'node_modules',
      '__pycache__'
    }
  },
  pickers = {
    find_files = picker_config,
    live_grep = picker_config,
    buffers = picker_config,
    help_tags = picker_config,
    commands = picker_config,
    lsp_references = picker_config,
    current_buffer_fuzzy_find = picker_config
  }
}

require('telescope').load_extension('fzf')

require('diffview')
