{ pkgs, ... }: {

	home.stateVersion = "23.05";

	programs = {
		
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
			".zshrc".source = ../../zshrc/.zshrc;
			".config/aerospace/aerospace.toml".source = ../../aerospace/aerospace.toml;
			".config/ghostty/config".source = ../../ghostty/config;
			".config/yazi/yazi.toml".source = ../../yazi/yazi.toml;
			".config/karabiner/karabiner.json".source = ../../karabiner/karabiner.json;
		};

		packages = with pkgs; [];
		sessionVariables = {
			EDITOR = "vim";
		};
	};

}
