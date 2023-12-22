-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

vim.keymap.set("n", "<C-n>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })

vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true })
vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true })
vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true })
vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true })
vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true })
