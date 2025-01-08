{ ... }:
let
	enableLanguages = langs: builtins.listToAttrs (map (lang: {
		name = lang;
		value = {
			enable = true;
			lsp.enable = true;
			treesitter.enable = true;
		};
	}) langs);

	silentNormalKeymap = key: action: {
		mode = "n";
		silent = true;
		inherit key;
		inherit action;
	};
in
	{
	programs.nvf = {

		enable = true;

		settings.vim = {

			keymaps = [
				(silentNormalKeymap "<leader>e" ":Neotree toggle<CR>")
				(silentNormalKeymap "<leader><space>" ":Telescope git_files<CR>")
			];

			theme = {
				enable = true;
				style = "mocha";
				transparent = true;
				name = "catppuccin";
			};

			ui = {
				colorizer.enable = true;
			};

			filetree.neo-tree = {
				enable = true;
			};

			statusline.lualine = {
				enable = true;
			};

			telescope.enable = true;

			assistant.copilot = {
				enable = true;
				cmp.enable = true;
			};

			comments.comment-nvim.enable = true;

			useSystemClipboard = true;

			treesitter.enable = true;

			languages = enableLanguages [
				"ts"
				"nix"
				"csharp"
			];

			autocomplete.nvim-cmp = {
				enable = true;
			};

		};
	};
}
