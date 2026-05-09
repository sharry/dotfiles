local function is_markdown(path)
	local ext = vim.fn.fnamemodify(path, ":e"):lower()
	return ext == "md" or ext == "markdown"
end

local function quicklook(path)
	vim.fn.jobstart({ "qlmanage", "-p", path }, { detach = true })
end

local function open_file(chosen_file)
	if vim.fn.has("mac") == 1 and is_markdown(chosen_file) then
		quicklook(chosen_file)
		return
	end

	require("yazi.openers").open_file(chosen_file)
end

local function open_file_in_vertical_split(chosen_file)
	if vim.fn.has("mac") == 1 and is_markdown(chosen_file) then
		quicklook(chosen_file)
		return
	end

	require("yazi.openers").open_file_in_vertical_split(chosen_file)
end

return {
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>e",
				function()
					require("yazi").yazi()
				end,
				desc = "Open file with Yazi",
			},
			{
				"<leader>p",
				function()
					require("yazi").yazi({
						open_file_function = open_file_in_vertical_split,
					})
				end,
				desc = "Open file in vertical split with Yazi",
			},
		},
		opts = {
			open_file_function = open_file,
			open_for_directories = false,
			floating_window_scaling_factor = 0.9,
			yazi_floating_window_border = "rounded",
		},
	},
}
