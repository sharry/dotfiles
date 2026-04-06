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
