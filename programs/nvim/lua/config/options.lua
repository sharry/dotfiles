-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.g.mapleader = ""
vim.g.maplocalleader = ""
vim.g.lazyvim_picker = "telescope"

-- Use <Del> as a leader proxy (no delete under cursor)
vim.keymap.set({ "n", "v", "o" }, "<Del>", "<Leader>", { remap = true, silent = true })
vim.opt.listchars = {
  tab = "⋅ ",
  trail = "-",
  nbsp = "+",
}

-- local java_17_home = vim.uv.os_getenv("JAVA_17_HOME");
-- if (java_17_home ~= nil) then
-- 	vim.uv.os_setenv("JAVA_HOME", java_17_home)
-- end
