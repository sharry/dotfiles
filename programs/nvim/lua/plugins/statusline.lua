local icons = LazyVim.config.icons
local noPadding = { left = 0, right = 0 };

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
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
