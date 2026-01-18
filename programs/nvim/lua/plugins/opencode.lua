return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			-- Calculate opencode port dynamically
			local function get_opencode_port()
				-- Try environment variable first (set by shell)
				local env_port = vim.env.OPENCODE_PORT
				if env_port and tonumber(env_port) then
					return tonumber(env_port)
				end

				-- Fallback: calculate it in Lua using same algorithm
				-- Check for submodule first
				local handle = io.popen("git rev-parse --show-superproject-working-tree 2>/dev/null")
				if not handle then
					return 50000
				end
				local superproject = handle:read("*l")
				handle:close()

				local git_dir
				if superproject and superproject ~= "" then
					-- In submodule - use parent repo
					handle = io.popen("cd '" .. superproject .. "' && git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null")
					if not handle then
						return 50000
					end
					git_dir = handle:read("*l")
					handle:close()
				else
					-- Normal repo
					handle = io.popen("git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null")
					if not handle then
						return 50000
					end
					git_dir = handle:read("*l")
					handle:close()
				end

				local hash_input
				if git_dir and git_dir ~= "" then
					hash_input = git_dir
				else
					-- Fallback to current directory
					hash_input = vim.fn.getcwd()
				end

				-- Calculate port from hash
				handle = io.popen("echo -n '" .. hash_input .. "' | md5 | cut -c1-8")
				if not handle then
					return 50000
				end
				local hash = handle:read("*l")
				handle:close()

				if hash and hash:match("^%x+$") then
					local port = tonumber("0x" .. hash) % 10000 + 50000
					return port
				end

				-- Ultimate fallback
				return 50000
			end

			-- Helper to check if server is running
			local function is_server_running(port)
				local check_cmd = string.format("curl -s http://localhost:%d/health >/dev/null 2>&1", port)
				vim.fn.system(check_cmd)
				return vim.v.shell_error == 0
			end

			-- Helper to start opencode server in zellij pane
			local function start_opencode_server(port, cwd)
				-- Close any existing opencode panes first to avoid hanging panes
				local close_cmd = 'zellij action close-pane --name opencode 2>/dev/null || true'
				vim.fn.system(close_cmd)
				-- Start new opencode instance in zellij pane
				local start_cmd = string.format('zellij run --name opencode --close-on-exit -- zsh -ic \'o "%s"\'', cwd)
				vim.fn.system(start_cmd)
				-- Wait for server to be ready (max 10 seconds)
				for _ = 1, 20 do
					if is_server_running(port) then
						return true
					end
					vim.cmd('sleep 500m')
				end
				return false
			end

			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "snacks",
					start = function(self)
						local port = get_opencode_port()
						local cwd = vim.fn.getcwd()
						-- Ensure server is running in zellij pane
						if not is_server_running(port) then
							if not start_opencode_server(port, cwd) then
								vim.notify("Failed to start opencode server", vim.log.levels.ERROR)
								return
							end
						end
						-- Don't create in-nvim terminal, just focus the zellij pane
						vim.fn.system('zellij action focus-pane --name opencode 2>/dev/null || true')
					end,
					stop = function(self)
						-- Close the zellij pane
						vim.fn.system('zellij action close-pane --name opencode 2>/dev/null || true')
					end,
					toggle = function(self)
						local port = get_opencode_port()
						if is_server_running(port) then
							-- Server running, try to focus or close
							self:stop()
						else
							-- Server not running, start it
							self:start()
						end
					end,
				},
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<leader>a", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
			-- vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
			-- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

			-- vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
			-- vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

			-- vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
			-- vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
			-- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
			-- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
		end,
	}
}
