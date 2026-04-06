return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			indent = { enable = true },
			highlight = { enable = true },
			folds = { enable = true },
		},
	},
	{
		"folke/flash.nvim",
		keys = {
			{
				"<Enter>",
				function()
					require("flash").treesitter({
						actions = {
							["<Enter>"] = "next",
							["<S-Enter>"] = "prev",
						},
					})
				end,
				desc = "Flash Treesitter",
			},
		},
	},
}
