require("utils")
local variant = SwitchThemeMode("latte", "mocha")

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-" .. variant,
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
