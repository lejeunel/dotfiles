-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>j", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>k", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "[D]elete Buffer" })
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "[S]ave" })

vim.keymap.set("n", "<C-j>", "<cmd>w<cr>", { desc = "[S]ave" })
