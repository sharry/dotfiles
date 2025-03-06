-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local telescope = require('telescope.builtin')

map('n', '<leader><space>', "<cmd>Telescope frecency workspace=CWD<cr><bs>", { desc = 'Telescope find files' })
map('n', '<leader>b', telescope.buffers, { desc = 'Telescope buffers' })

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
map("n", "<S-Up>", "10k", { desc = "Scroll Up" })
map("n", "<S-Down>", "10j", { desc = "Scroll Down" })
map("n", "<S-Left>", "zH", { desc = "Scroll Left" })
map("n", "<S-Right>", "zL", { desc = "Scroll Right" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })

if vim.fn.executable("lazygit") == 1 then
	map("n", "<leader>gg",
		function()
			vim.cmd("silent !$SHELL -i -c 'g'")
		end,
		{ desc = "Lazygit (Root Dir)" }
	)
end

if vim.fn.executable("serpl") == 1 then
	map("n", "<leader>sr",
		function()
			vim.cmd("silent !$SHELL -i -c 'sr'")
		end,
		{ desc = "Serpl (Search & Replace)" }
	)
end
