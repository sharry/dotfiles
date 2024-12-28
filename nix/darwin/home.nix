{ pkgs, ... }: {

	home.stateVersion = "23.05";
	programs.home-manager.enable = true;


	home = {

		file = {
			".zshrc".source = ../../zshrc/.zshrc;
		};

		packages = with pkgs; [];
		sessionVariables = {
			EDITOR = "vim";
		};
	};

}
