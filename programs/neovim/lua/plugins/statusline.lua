local catppuccin = require("lualine.themes.catppuccin")
catppuccin.normal.c.bg = "#00000000"

local icons = LazyVim.config.icons

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = catppuccin,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_c = {
					{ "filetype", icon_only = true },
					{ "filename" },
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
