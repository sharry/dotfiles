{ pkgs, ... }: {

	home.stateVersion = "23.05";

	programs = {

		zsh = {
			
			enable = true;
			enableCompletion = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;

			shellAliases = {
				v = "nvim";
				c = "clear";
				y = "yazi";
				ll = "ls -l";
				renix = "darwin-rebuild switch --flake ~/dotfiles/nix/darwin#sharry && source ~/.zshrc";
			};

			oh-my-zsh = {
				enable = true;
				plugins = ["git"];
				theme = "robbyrussell";
  			};

		};
		
		home-manager = {
			enable = true;
		};

		git = {
			enable = true;
			userName = "Youssef Ben Sadik";
			userEmail = "youssef@bensadik.net";
			ignores = [
				".DS_Store"
			];
			extraConfig = {
				init.defaultBranch = "main";
				push.autoSetupRemote = true;
			};
		};
		
	};

	home = {

		file = {
			".config/aerospace/aerospace.toml".source = ../../aerospace/aerospace.toml;
			".config/ghostty/config".source = ../../ghostty/config;
			".config/yazi/yazi.toml".source = ../../yazi/yazi.toml;
			".config/karabiner/karabiner.json".source = ../../karabiner/karabiner.json;
			".config/lazygit/config.yml".source = ../../lazygit/config.yml;
			".ssh/config".source = ../../ssh/config;
		};

		packages = with pkgs; [];
		sessionVariables = {
			EDITOR = "vim";
		};
	};

}
