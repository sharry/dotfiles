return {
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("yazi").yazi()
				end,
				desc = "Open file with Yazi",
			},
			{
				"<leader>p",
				function()
					require("yazi").yazi({
						open_file_function = require("yazi.openers").open_file_in_vertical_split,
					})
				end,
				desc = "Open file in vertical split with Yazi",
			},
		},
		opts = {
			open_for_directories = false,
			floating_window_scaling_factor = 0.9,
			yazi_floating_window_border = "rounded",
		},
	},
}
