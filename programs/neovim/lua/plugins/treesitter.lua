return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>",
				node_incremental = "<Enter>",
				node_decremental = "<S-Enter>",
			},
		},
	},
}
