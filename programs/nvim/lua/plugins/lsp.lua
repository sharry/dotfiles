local java_filetypes = { "java" }
local root_markers = {
	".git",
	"mvnw",
	"gradlew",
	"pom.xml",
	"build.gradle",
	"build.gradle.kts",
	"settings.gradle",
	"settings.gradle.kts",
}
local spring_boot_bundle_names = {
	["io.projectreactor.reactor-core.jar"] = true,
	["org.reactivestreams.reactive-streams.jar"] = true,
	["jdt-ls-commons.jar"] = true,
	["jdt-ls-extension.jar"] = true,
	["sts-gradle-tooling.jar"] = true,
}

local function lsp_capabilities()
	if LazyVim.has("blink.cmp") then
		return require("blink.cmp").get_lsp_capabilities()
	end

	if LazyVim.has("cmp-nvim-lsp") then
		return require("cmp_nvim_lsp").default_capabilities()
	end
end

local function glob_paths(pattern)
	return vim.fn.glob(pattern, false, true)
end

local function has_debug_bundle()
	local extension_path = vim.env.JAVA_DEBUG_EXTENSION_PATH
	if not extension_path or extension_path == "" then
		return false
	end

	return #glob_paths(extension_path .. "/server/com.microsoft.java.debug.plugin-*.jar") > 0
end

local function has_test_bundle()
	local extension_path = vim.env.JAVA_TEST_EXTENSION_PATH
	if not extension_path or extension_path == "" then
		return false
	end

	return #glob_paths(extension_path .. "/server/com.microsoft.java.test.plugin-*.jar") > 0
end

local function spring_boot_bundles()
	local extension_path = vim.env.SPRING_BOOT_EXTENSION_PATH
	if not extension_path or extension_path == "" then
		return {}
	end

	return vim.tbl_filter(function(path)
		return spring_boot_bundle_names[vim.fs.basename(path)] == true
	end, glob_paths(extension_path .. "/jars/*.jar"))
end

local function collect_bundles()
	local bundles = {}
	local debug_path = vim.env.JAVA_DEBUG_EXTENSION_PATH
	local test_path = vim.env.JAVA_TEST_EXTENSION_PATH

	if debug_path and debug_path ~= "" then
		vim.list_extend(bundles, glob_paths(debug_path .. "/server/com.microsoft.java.debug.plugin-*.jar"))
	end

	if test_path and test_path ~= "" then
		vim.list_extend(bundles, glob_paths(test_path .. "/server/*.jar"))
	end

	vim.list_extend(bundles, spring_boot_bundles())

	return bundles
end

local function java_root_dir(path)
	return vim.fs.root(path, root_markers) or vim.uv.cwd()
end

local function project_name(root_dir)
	return root_dir and vim.fs.basename(root_dir) or nil
end

local function full_jdtls_cmd(root_dir)
	local cmd = { vim.fn.exepath("jdtls") }
	local name = project_name(root_dir)

	if not name then
		return cmd
	end

	local cache_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. name
	vim.list_extend(cmd, {
		"-configuration",
		cache_dir .. "/config",
		"-data",
		cache_dir .. "/workspace",
	})

	return cmd
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}

			if type(opts.ensure_installed) == "table" and not vim.tbl_contains(opts.ensure_installed, "java") then
				table.insert(opts.ensure_installed, "java")
			end
		end,
	},
	{
		"JavaHello/spring-boot.nvim",
		ft = { "java", "yaml", "jproperties" },
		config = function()
			local extension_path = vim.env.SPRING_BOOT_EXTENSION_PATH
			local ls_path = nil

			if extension_path and extension_path ~= "" then
				local matches = glob_paths(extension_path .. "/language-server/spring-boot-language-server*.jar")
				ls_path = matches[1]
			end

			require("spring_boot").setup({ ls_path = ls_path })
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = java_filetypes,
		dependencies = {
			"JavaHello/spring-boot.nvim",
			"folke/which-key.nvim",
		},
		config = function()
			local function attach_jdtls()
				local filename = vim.api.nvim_buf_get_name(0)
				local root_dir = java_root_dir(filename)
				if not root_dir then
					return
				end

				require("jdtls").start_or_attach({
					cmd = full_jdtls_cmd(root_dir),
					root_dir = root_dir,
					init_options = {
						bundles = collect_bundles(),
					},
					settings = {
						java = {
							inlayHints = {
								parameterNames = {
									enabled = "all",
								},
							},
						},
					},
					capabilities = lsp_capabilities(),
				})
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = java_filetypes,
				callback = attach_jdtls,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "jdtls" then
						return
					end

					local wk = require("which-key")
					wk.add({
						{
							mode = "n",
							buffer = args.buf,
							{ "<leader>co", require("jdtls").organize_imports, desc = "Organize Imports" },
							{ "<leader>cgs", require("jdtls").super_implementation, desc = "Goto Super" },
							{ "<leader>cx", group = "extract" },
							{ "<leader>cxc", require("jdtls").extract_constant, desc = "Extract Constant" },
							{ "<leader>cxv", require("jdtls").extract_variable_all, desc = "Extract Variable" },
						},
					})
					wk.add({
						{
							mode = "x",
							buffer = args.buf,
							{ "<leader>cx", group = "extract" },
							{
								"<leader>cxm",
								[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
								desc = "Extract Method",
							},
						},
					})

					local has_dap, dap = pcall(require, "dap")
					if not has_dap or not has_debug_bundle() then
						return
					end

					dap.configurations.java = {
						{
							type = "java",
							request = "attach",
							name = "Debug (Attach) - Remote",
							hostName = "127.0.0.1",
							port = 5005,
						},
					}

					require("jdtls").setup_dap({ hotcodereplace = "auto" })
					require("jdtls.dap").setup_dap_main_class_configs()

					if not has_test_bundle() then
						return
					end

					wk.add({
						{
							mode = "n",
							buffer = args.buf,
							{ "<leader>t", group = "test" },
							{ "<leader>tt", require("jdtls.dap").test_class, desc = "Run All Test" },
							{ "<leader>tr", require("jdtls.dap").test_nearest_method, desc = "Run Nearest Test" },
							{ "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
						},
					})
				end,
			})

			attach_jdtls()
		end,
	},
}
