-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local telescope = require('telescope.builtin')
local function map_floating_zellij_job(details)
	if vim.fn.executable(details.kill or details.command()) == 1 then
		map("n", details.keybind,
			function()
				vim.fn.system("pkill " .. (details.kill or details.command()))
				vim.fn.jobstart(
					{
						"zellij", "run", "--floating", "--close-on-exit", "--name", details.desc,
						"--width", "90%", "--height", "90%", "-x", "5%", "-y", "10%",
						"--", "sh", "-c", details.command({
							server = vim.v.servername,
							dir = vim.fn.expand('%:p:h') or vim.fn.getcwd()
						})
					},
					{ detach = true }
				)
			end,
			{ desc = details.desc }
		)
	end
end

map('n', '<leader>b', telescope.buffers, { desc = 'Telescope buffers' })
map('n', '<leader><space>', "<cmd>Telescope frecency workspace=CWD<cr><bs>", { desc = 'Telescope find files' })

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
map("n", "<S-Up>", "10k", { desc = "Scroll Up" })
map("n", "<S-Down>", "10j", { desc = "Scroll Down" })
map("n", "<S-Left>", "zH", { desc = "Scroll Left" })
map("n", "<S-Right>", "zL", { desc = "Scroll Right" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })

map_floating_zellij_job({
	command = function() return "lazygit" end,
	desc = "Lazygit",
	keybind = "<leader>gg"
})

map_floating_zellij_job({
	command = function() return "serpl" end,
	desc = "Serpl (Search & Replace)",
	keybind = "<leader>sr"
})

map_floating_zellij_job({
	command = function(args)
		return [[
		_f() {
			export EDITOR="nvim --server ]] .. args.server .. [[ --remote";
			yazi ]] .. args.dir .. [[;
		};_f
	]]
	end,
	kill = "yazi",
	desc = "Yazi",
	keybind = "<leader>e"
})

