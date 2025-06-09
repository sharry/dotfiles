return {
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup {
				execution_message = {
					message = function()
						return ""
					end,
					dim = 0.18,
					cleaning_interval = 1250,
				}
			}
		end,
	}
}
