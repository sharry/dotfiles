-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local telescopeBuiltin = require('telescope.builtin')

map('n', '<leader><space>', "<cmd>Telescope frecency workspace=CWD<cr>", { desc = 'Telescope find files' })
map('n', '<leader>/', telescopeBuiltin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>b', telescopeBuiltin.buffers, { desc = 'Telescope buffers' })

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
map("n", "<S-Up>", "10k", { desc = "Scroll Up" })
map("n", "<S-Down>", "10j", { desc = "Scroll Down" })
map("n", "<S-Left>", "zH", { desc = "Scroll Left" })
map("n", "<S-Right>", "zL", { desc = "Scroll Right" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })
