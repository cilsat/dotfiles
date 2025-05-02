-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.wo.number = true -- Always show line numbers

local augroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- Enable relative numbers in Normal mode
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group = augroup,
  pattern = "*:*",
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" or mode == "v" then
      vim.wo.relativenumber = true
    else
      vim.wo.relativenumber = false
    end
  end,
})
