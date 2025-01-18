{ pkgs, ... }:
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

	keymap = { key, action, mode ? ["n"], silent ? true }: {
		inherit key;
		inherit mode;
		inherit silent;
		inherit action;
	};

	enterCmd = cmd: action: "<CMD>${cmd} ${action}<CR>";
	luaCmd = pkg: func: enterCmd "lua" ''require("${pkg}").${func}()'';

	emptySetup = require: "require('${require}').setup {}";

	leader = "<leader>";
in
{
	programs.nvf = {
		enable = true;
		settings.vim = {

			enableLuaLoader = true;
			preventJunkFiles = true;

			lsp = {
				enable = true;
				formatOnSave = true;
				lspkind.enable = true;
				lsplines.enable = true;
				lspconfig.enable = true;
				lightbulb.enable = true;
				lspSignature.enable = true;
			};

			lineNumberMode = "number";
			hideSearchHighlight = true;

			options = {
				wrap = false;
				smoothscroll = true;
			};

			keymaps = [
				(keymap {
					key = leader + "e";
					action = enterCmd "Neotree" "toggle";
				})
				(keymap {
					key = leader + "<space>";
					action = enterCmd "Telescope" "git_files";
				})
				(keymap {
					key = "K";
					action = luaCmd "hover" "hover";
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
				nvim-ufo.enable = true;
			};

			filetree.neo-tree = {
				enable = true;
			};

			statusline.lualine.enable = true;

			telescope.enable = true;

			assistant.copilot = {
				enable = true;
				setupOpts = {
					suggestion = {
						enable = true;
						auto_trigger = true;
						keymap.accept = "<Tab>";
					};
					panel.enable = true;
				};
			};

			comments.comment-nvim.enable = true;

			useSystemClipboard = true;

			treesitter = {
				enable = true;
				fold = true;
			};

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
				mappings = {
					next = "<Down>";
					previous = "<Up>";
				};
			};

			autopairs.nvim-autopairs.enable = true;

			visuals = {
				nvim-cursorline = {
					enable = true;
					setupOpts ={
						cursorline = {
							enable = true;
							timeout = 0;
						};
						cursorword.enable = true;
					};
				};

				indent-blankline.enable = true;
			};

			debugger.nvim-dap = {
				enable = true;
				ui.enable = true;
			};

			# Translated to `vim.o.*` options
			options = {
				foldenable = true;
				foldcolumn = "1";
				foldlevel = 99;
				foldlevelstart = 99;
				fillchars = "eob: ,fold: ,foldsep: ,foldopen:,foldclose:";
			};

			lazy.plugins = with pkgs.vimPlugins; {
				"multicursors.nvim" = {
					lazy = true;
					setupModule = "multicursors";
					package = multicursors-nvim;
					cmd = ["MCstart" "MCvisual" "MCclear" "MCpattern" "MCvisualPattern" "MCunderCursor"];
					keys = [
						(keymap {
							mode = [ "n" "v" ];
							key = leader + "m";
							action = enterCmd "MCstart" "";
						})
					];
				};
			};

			extraPlugins = with pkgs.vimPlugins; {
				dropbar = {
					package = dropbar-nvim;
					setup = emptySetup "dropbar";
				};

				statuscol = {
					package = statuscol-nvim;
					setup = ''
						local builtin = require("statuscol.builtin")
						require("statuscol").setup {
							relculright = true,
							segments = {
								{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
								{ text = { "%s" }, click = "v:lua.ScSa" },
								{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
							},
						}
					'';
				};

				hover = {
					package = hover-nvim;
					setup = ''
						require("hover").setup {
							init = function()
								require("hover.providers.lsp")
							end,
							preview_opts = {
								border = 'single'
							},
							preview_window = false,
							title = true,
							mouse_providers = {
								'LSP'
							},
							mouse_delay = 1000
						}
					'';
				};
			};

		};
	};
}
