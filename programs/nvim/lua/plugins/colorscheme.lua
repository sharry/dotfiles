return {
	{ "vimpostor/vim-lumen" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				require("catppuccin").load()
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			transparent_background = true,
			float = {
				transparent = true,
			},
		},
	},
}
