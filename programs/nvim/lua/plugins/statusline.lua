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
				lualine_y = {
					{
						function()
							local expandtab = vim.bo.expandtab
							local shiftwidth = vim.bo.shiftwidth
							local tabsize = vim.bo.tabstop
							if expandtab then
								return string.format("SPC %d", shiftwidth)
							else
								return string.format("TAB %d", tabsize)
							end
						end,
					},
					{
						function()
							local fileformat = vim.bo.fileformat

							local separators = {
								unix = "LF",
								dos = "CRLF",
								mac = "CR"
							}

							return separators[fileformat] or separators[1]
						end,
					},
					{
						function ()
							local encoding = vim.bo.fenc
							return string.upper(encoding)
						end,
					}
				},
				lualine_z = {
					{
						function()
							local col = vim.fn.col(".")
							local line = vim.fn.line(".")
							return string.format("%d:%d  ", line, col)
						end,
					}
				}
			},
		},
	},
}
