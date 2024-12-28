{ pkgs, ... }: {

	home.stateVersion = "23.05";
	programs.home-manager.enable = true;


	home = {
		packages = with pkgs; [];
		sessionVariables = {
			EDITOR = "vim";
		};
	};

}
