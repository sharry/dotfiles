{ pkgs, ... }: {

	home.stateVersion = "23.05";

	imports = [
		./zsh.nix
	];

	programs = {

		java  = {
			enable = true;
			package = pkgs.jdk17;
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
			".config/aerospace/aerospace.toml".source = ./aerospace/aerospace.toml;
			".config/ghostty/config".source = ./ghostty/config;
			".config/yazi/yazi.toml".source = ./yazi/yazi.toml;
			".config/karabiner/karabiner.json".source = ./karabiner/karabiner.json;
			".config/lazygit/config.yml".source = ./lazygit/config.yml;
			".ssh/config".source = ./ssh/config;
		};

		sessionVariables = {
			EDITOR = "code";
		};
	};

}
