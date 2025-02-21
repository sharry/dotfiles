require("utils")

local catppuccin_latte = require("lualine.themes.catppuccin-latte")
local catppuccin_mocha = require("lualine.themes.catppuccin-mocha")
catppuccin_latte.normal.c.bg = "#00000000"
catppuccin_mocha.normal.c.bg = "#00000000"

local catppuccin = SwitchThemeMode(catppuccin_latte, catppuccin_mocha)

local icons = LazyVim.config.icons
local noPadding = { left = 0, right = 0 };

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = catppuccin,
				component_separators = "",
				section_separators = { right = "", left = "" },
			},
			sections = {
				lualine_c = {
					{
						function() return " " end,
						padding = noPadding,
					},
					{
						"filetype",
						icon_only = true,
						padding = noPadding,
					},
					{ "filename", padding = noPadding },
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
					},
				},
			},
		},
	},
}
