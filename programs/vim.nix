let
	enableLanguages = langs: builtins.listToAttrs (map ({ name, withTreesitter ? true, withLsp ? true, extensions ? {} }: {
		inherit name;
		value = {
			enable = true;
		}
		// (if withLsp then {
			lsp.enable = true;
		} else {})
		// (if withTreesitter then {
			treesitter.enable = true;
		} else {})
		// (if extensions != {} then {
			inherit extensions;
		} else {});
	}) langs);

	silentNormalKeymap = { key, action }: {
		mode = "n";
		silent = true;
		inherit key;
		inherit action;
	};

	enterCmd = cmd: action: ":${cmd} ${action}<CR>";
in
{
	programs.nvf = {
		enable = true;
		settings.vim = {

			lsp = {
				enable = true;
				formatOnSave = true;
				lightbulb.enable = true;
			};

			lineNumberMode = "number";
			hideSearchHighlight = true;

			spellcheck = {
				enable = true;
				languages = ["en"];
				programmingWordlist.enable = true;
				extraSpellWords."en.utf-8" = [
					"darwin" "homebrew" "dotfiles" "macOS"
				];
			};

			options = {
				wrap = false;
				smoothscroll = true;
			};

			keymaps = [
				(silentNormalKeymap {
					key = "<leader>" + "e";
					action = enterCmd "Neotree" "toggle";
				})
				(silentNormalKeymap {
					key = "<leader>" + "<space>";
					action = enterCmd "Telescope" "git_files";
				})
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
				{ name = "ts"; }
				{ name = "nix"; }
				{ name = "java"; }
				{ name = "csharp"; }
				{ name = "tailwind"; withTreesitter = false; }
				{ name = "markdown"; extensions = { render-markdown-nvim.enable = true; }; }
			];

			autocomplete.nvim-cmp = {
				enable = true;
			};

		};
	};
}
