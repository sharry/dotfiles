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

			local function opencode_cmd()
				return "opencode --port " .. get_opencode_port()
			end

			local function opencode_terminal_opts()
				return {
					split = "right",
					width = math.floor(vim.o.columns * 0.35),
				}
			end

			---@type opencode.Opts
			vim.g.opencode_opts = {
				server = {
					port = function(callback)
						callback(get_opencode_port())
					end,
					start = function()
						require("opencode.terminal").open(opencode_cmd(), opencode_terminal_opts())
					end,
					stop = function()
						require("opencode.terminal").close()
					end,
					toggle = function()
						require("opencode.terminal").toggle(opencode_cmd(), opencode_terminal_opts())
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
