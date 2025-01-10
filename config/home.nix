{

	imports = [
		./pkgs.nix
		../programs
	];

	home = {

		file.".hushlogin".text = ""; # Stops showing the last login message

		stateVersion = "23.05";

		sessionVariables = {
			EDITOR = "nvim";
		};

	};

	programs.home-manager.enable = true;

}
