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

-- TODO: Config Java
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "java",
-- 	callback = function()
-- 		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- 		local workspace_dir = "~/.workspace/" .. project_name
-- 		local java_23_home = vim.uv.os_getenv("JAVA_23_HOME");
-- 		if java_23_home == nil then
-- 			print("JAVA_23_HOME is not set")
-- 			return
-- 		end
-- 		vim.uv.os_setenv("JAVA_HOME", java_23_home);
-- 		local config = {
-- 			cmd = {
-- 				java_23_home .. "/bin/java",
-- 				-- "-javaagent:/home/jake/.local/share/java/lombok.jar",
-- 				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
-- 				"-Dosgi.bundles.defaultStartLevel=4",
-- 				"-Declipse.product=org.eclipse.jdt.ls.core.product",
-- 				"-Dlog.protocol=true",
-- 				"-Dlog.level=ALL",
-- 				"-Xms1g",
-- 				"--add-modules=ALL-SYSTEM",
-- 				"--add-opens",
-- 				"java.base/java.util=ALL-UNNAMED",
-- 				"--add-opens",
-- 				"java.base/java.lang=ALL-UNNAMED",
-- 				"-jar",
-- 				vim.fn.glob("$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"),
-- 				"-configuration",
-- 				"$JDTLS_HOME/config_linux",
-- 				"-data", workspace_dir,
-- 			},
-- 			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
-- 			settings = {
-- 				java = {},
-- 			},
-- 		}
-- 		require("jdtls").start_or_attach(config)
-- 	end,
-- })
