{ pkgs, ... }: {

	home.stateVersion = "23.05";
	programs.home-manager.enable = true;


	home = {

		file = {
			".zshrc".source = ../../zshrc/.zshrc;
			".config/aerospace/aerospace.toml".source = ../../aerospace/aerospace.toml;
			".config/ghostty/config".source = ../../ghostty/config;
		};

		packages = with pkgs; [];
		sessionVariables = {
			EDITOR = "vim";
		};
	};

}
