-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
