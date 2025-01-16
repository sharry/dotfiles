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
			DOCKER_HOST = "unix://$(dirname $(dirname $(podman machine info --format '{{.Host.EventsDir}}')))/podman/$(podman machine info --format '{{.Host.CurrentMachine}}')-api.sock";
		};

	};

	programs.home-manager.enable = true;

}
