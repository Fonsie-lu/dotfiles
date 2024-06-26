-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", ":w<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "q", ":q<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a", ":HopWord<cr>", { noremap = true, silent = true })
