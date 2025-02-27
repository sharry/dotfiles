return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		config = function()
			require("telescope").setup({
				extensions = {
					frecency = {
						show_scores = true,
						show_filter_column = false,
					}
				}
			})
			require("telescope").load_extension "frecency"
		end,
	},
}
