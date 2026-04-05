return {
	{ "vimpostor/vim-lumen" },
	{
		"LazyVim/LazyVim",
		opts = {
			-- Neovim 0.12 ships a built-in `catppuccin` colorscheme.
			-- Load the plugin directly so our catppuccin options still apply.
			colorscheme = function()
				require("catppuccin").load()
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			transparent_background =  true,
		},
	},
}
