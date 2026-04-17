-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local telescope = require("telescope.builtin")

local function flash_treesitter()
	require("flash").treesitter({
		actions = {
			["<Enter>"] = "next",
			["<S-Enter>"] = "prev",
		},
	})
end

map("n", "<leader>b", telescope.buffers, { desc = "Telescope buffers" })
map("n", "<leader>r", ":LspRestart<CR>", { desc = "Restart LSP" })
map('n', '<leader><Del>', "<cmd>Telescope frecency workspace=CWD<cr><bs>", { desc = 'Telescope find files' })

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
map("n", "<S-Up>", "10k", { desc = "Scroll Up" })
map("n", "<S-Down>", "10j", { desc = "Scroll Down" })
map("n", "<S-Left>", "zH", { desc = "Scroll Left" })
map("n", "<S-Right>", "zL", { desc = "Scroll Right" })
map("n", "<S-Del>", "ciw", { desc = "Cut Inside Word" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })
map("n", "<Enter>", flash_treesitter, { desc = "Flash Treesitter" })
map("n", "<S-Enter>", flash_treesitter, { desc = "Flash Treesitter" })

if vim.fn.executable("serpl") == 1 then
	map("n", "<leader>sr", function()
		require("snacks").terminal({ "serpl" }, {
			cwd = vim.fn.getcwd(),
			win = {
				position = "float",
				border = "rounded",
			},
		})
	end, { desc = "Serpl (Search & Replace)" })
end

map("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
