vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.b.autoformat = false
	end,
})

local function force_buffer_on_tab()
    local tab_count = #vim.api.nvim_list_tabpages()
    if tab_count > 1 then
        vim.cmd("tabclose")
        vim.cmd("enew")
        vim.bo.bufhidden = "wipe"
    end
end

vim.api.nvim_create_autocmd("TabNewEntered", {
    callback = force_buffer_on_tab
})
