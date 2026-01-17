-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set
local telescope = require("telescope.builtin")
local function map_floating_zellij_job(details)
	if vim.fn.executable(details.kill or details.command()) == 1 then
		map("n", details.keybind, function()
			vim.fn.system("pkill " .. (details.kill or details.command()))
			vim.fn.jobstart({
				"zellij",
				"run",
				"--floating",
				"--close-on-exit",
				"--name",
				details.desc,
				"--width",
				"90%",
				"--height",
				"90%",
				"-x",
				"5%",
				"-y",
				"8%",
				"--",
				"sh",
				"-c",
				details.command({
					server = vim.v.servername,
					file = vim.fn.fnamemodify(vim.fn.bufname(), ':p'),
				}) .. "; zellij action toggle-floating-panes",
			}, { detach = true })
		end, { desc = details.desc })
	end
end

map("n", "<leader>b", telescope.buffers, { desc = "Telescope buffers" })
map("n", "<leader>r", ":LspRestart<CR>", { desc = "Restart LSP" })
map('n', '<leader><space>', "<cmd>Telescope frecency workspace=CWD<cr><bs>", { desc = 'Telescope find files' })

map("n", "go", "<C-o>", { desc = "Jump back" })
map("n", "gi", "<C-i>", { desc = "Jump forward" })
map("n", "<S-Up>", "10k", { desc = "Scroll Up" })
map("n", "<S-Down>", "10j", { desc = "Scroll Down" })
map("n", "<S-Left>", "zH", { desc = "Scroll Left" })
map("n", "<S-Right>", "zL", { desc = "Scroll Right" })
map("n", "<S-Del>", "ciw", { desc = "Cut Inside Word" })
map("n", "<leader>fx", ":!chmod +x %<CR>", { desc = "Make file executable" })

map_floating_zellij_job({
	command = function()
		return "lazygit"
	end,
	desc = "Lazygit",
	keybind = "<leader>gg",
})

map_floating_zellij_job({
	command = function()
		return "serpl"
	end,
	desc = "Search & Replace",
	keybind = "<leader>sr",
})

map_floating_zellij_job({
	command = function(args)
		return [[
		_f() {
			local tmp="$(mktemp -t "yazi-chooser.XXXXX")"
			yazi "]] .. args.file .. [[" --chooser-file="$tmp";
			local opened_file="$(cat -- "$tmp" | head -n 1)";
			nvim --server ]] .. args.server .. [[ --remote "$opened_file";
			rm -f -- "$tmp";
			zellij action toggle-floating-panes;
			exit;
		};_f
	]]
	end,
	kill = "yazi",
	desc = "Open file with Yazi",
	keybind = "<leader>e",
})

map_floating_zellij_job({
	command = function(args)
		return [[
		_f() {
			local tmp="$(mktemp -t "yazi-chooser.XXXXX")"
			yazi "]] .. args.file .. [[" --chooser-file="$tmp";
			local opened_file="$(cat -- "$tmp" | head -n 1)";
			rm -f -- "$tmp";
			if [ -f "$opened_file" ]; then
				zellij run --close-on-exit -- nvim "$opened_file"
			fi
			exit;
		};_f
	]]
	end,
	kill = "yazi",
	desc = "Open file in new pane with Yazi",
	keybind = "<leader>p",
})

map_floating_zellij_job({
	command = function(args)
		return [[
		_f() {
			project_name=$(basename "$PWD")
			list_cmd='project_name=$(basename "$PWD"); { fre --sorted | rg "^$PWD/" | sed "s|^$PWD|$project_name|" | awk '\''{print "\033[1;32m" $0 "\033[0m"}'\''; rg --files | sed "s|^|$project_name/|"; } | awk '\''{key=$0; gsub(/\x1b\[[0-9;]*m/, "", key); if (!seen[key]++) print $0}'\'''
			selected=$(sh -c "$list_cmd" | fzf --ansi --no-sort --preview-window "up:80%" --preview "bat --plain --theme=catppuccin-mocha --color=always \"\$PWD/\$(echo {} | sed -E 's/\x1b\[[0-9;]*m//g' | sed 's|^$project_name/||')\"" --bind "del:execute-silent(fre --delete \"\$PWD/\$(echo {} | sed -E 's/\x1b\[[0-9;]*m//g' | sed 's|^$project_name/||')\")+reload($list_cmd)")
			if [ -n "$selected" ]; then
				nvim --server ]].. args.server ..[[ --remote "$PWD/$(echo "$selected" | sed -E 's/\x1b\[[0-9;]*m//g' | sed "s|^$project_name/||")";
			fi
		};_f
	]]
	end,
	kill = "fzf",
	desc = "Open File",
	keybind = "<leader><Del>",
})

map_floating_zellij_job({
	command = function(args)
		return [[
		_f() {
			selected=$(rg --column --line-number --no-heading --color=always --smart-case --fixed-strings '' | \
				fzf --ansi --phony --query "" \
				--bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case --fixed-strings {q} || true" \
				--delimiter ":" \
				--preview "bat --plain --theme=catppuccin-mocha --color=always --highlight-line {2} {1}" \
				--preview-window "up:80%")
			if [ -n "$selected" ]; then
				clean=$(printf "%s" "$selected" | sed -E 's/\x1b\[[0-9;]*m//g' | tr -d '\r')
				file=$(printf "%s" "$clean" | cut -d: -f1)
				line=$(printf "%s" "$clean" | cut -d: -f2)
				full_path="$PWD/$file"
				nvim --server ]].. args.server ..[[ --remote-expr "luaeval('vim.api.nvim_command(\"edit $full_path | $line\")')";
			fi
		};_f
	]]
	end,
	kill = "fzf",
	desc = "Search",
	keybind = "<leader>/",
})
