-- Organizes imports: Useful for gopls
function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
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
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>m', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<F6>', '<cmd>lua org_imports(250)<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<M-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<M-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<F4>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<F4>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.fn.sign_define('LspDiagnosticsSignError', {
      text = '', texthl = 'LspDiagnosticsSignError';
    })
    vim.fn.sign_define('LspDiagnosticsSignError', {
      text='▎', texthl = 'LspDiagnosticsSignError';
    })
    vim.fn.sign_define('LspDiagnosticsSignWarning', {
      text='▎', texthl = 'LspDiagnosticsSignWarning';
    })
    vim.fn.sign_define('LspDiagnosticsSignInformation', {
      text='▎', texthl = 'LspDiagnosticsSignInformation';
    })
    vim.fn.sign_define('LspDiagnosticsSignHint', {
      text='▎', texthl = 'LspDiagnosticsSignHint';
    })

    vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
  }
  -- Floating windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {border = border}
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.hover, {border = border}
  )
end

-- Enable snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Use a loop to conveniently both setup all defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  "clangd", "intelephense", "gopls", "jdtls", "rust_analyzer", "tsserver"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup Lua completion manually
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').sumneko_lua.setup {
  cmd = {'lua-language-server'},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
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

require'lspconfig'.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end
}

-- LSP completion config via nvim-compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = {"🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏",},
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    nvim_treesitter = true;
  };
}

-- Use <Tab> and <S-Tab> to navigate nvim-compe completion menu
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.compe_cr = function()
	if vim.fn.pumvisible() == 1 and vim.fn.complete_info()['selected'] ~= -1 then
		-- return t("<Plug>(compe-confirm)")
		vim.fn['compe#confirm']({select = true})
	else
		return require("consclose").consCR() .. t("<Plug>DiscretionaryEnd")
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.compe_cr()", {expr = true})
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Lspsaga setup for prettier/smarter popups
--require'lspsaga'.init_lsp_saga {
--  border_style = 1
--}

-- LSP symbol tree viewer
require'symbols-outline'.setup {
  highlight_hovered_item = true;
  show_guides = true;
}

-- Load autopairs
require('nvim-autopairs').setup({
  check_ts = true,
  fast_wrap = {
    end_key = 'e',
    keys = {'asdfghjkl;qwriop['},
    highlight = 'Sneak',
  }
})
require('nvim-autopairs.completion.compe').setup({
  map_cr = true,
  map_complete = true,
})

-- nvim-treesitter for vastly improved source code parsing
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "c", "cpp", "go", "java", "javascript", "json", "julia", "kotlin",
    "lua", "php", "python", "query", "ruby", "rust", "toml", "typescript", "vue"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
}

-- lsp-kind for pretty icons in completion menu
require('lspkind').init({
  with_text = false,
  symbol_map = {
    Text = '  ',
    Method = ' ƒ',
    Function = '  ',
    Constructor = '  ',
    Variable = ' []',
    Class = '  ',
    Interface = ' 蘒',
    Module = '  ',
    Property = '  ',
    Unit = ' 塞 ',
    Value = '  ',
    Enum = ' 練',
    Keyword = '  ',
    Snippet = '  ',
    Color = '',
    File = '',
    Folder = ' ﱮ ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  '
  },
})

-- telescope for fuzzy searching
local picker_config = {
  show_line = false;
  prompt_title = '';
  results_title = '';
  preview_title = '';
}

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--column', '--smart-case', '--color=never', '--no-heading',
      '--with-filename', '-uu', '-F', '-L', '-g', '!.git/**',
      '-g', '!__pycache__/**', '-g', '!node_modules', '-g', '!**.o'
    },
    find_command = {
      'fd', '-i', '-uu', '-F', '-L', '-S', '-1m',
      '-E', '.git', '-E', 'node_modules', '-E', '__pycache__', '-E', '**.o',
      '-E', '*.jpg', '-E', '*.wav'
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
    },
    borderchars = {
      results = {'▔', '▕', '▁', '▏', '🭽', '🭾', '🭿', '🭼' };
      prompt = {' ', '▕', '▁', '▏', '▏', '▕', '🭿', '🭼' };
      preview = {'▔', '▕', '▁', ' ', '▔', '🭾', '🭿', '▁' };
    },
    layout_strategy = 'flex',
    layout_config = {
      height = 0.7
    },
  },
  pickers = {
    find_files = picker_config,
    live_grep = picker_config,
    buffers = picker_config,
    help_tags = picker_config,
    commands = picker_config,
    lsp_references = picker_config,
  }
}

require('telescope').load_extension('fzy_native')
