{ config, lib, ... }:
let
	symlinkConfigDir = directory: ''
		run ln --symbolic --force $VERBOSE_ARG ${config.home.homeDirectory}/dotfiles/programs/${directory} ${config.home.homeDirectory}/.config/${directory};
	'';
	symlinkConfigFile = path: ''
		run ln --symbolic --force $VERBOSE_ARG ${config.home.homeDirectory}/dotfiles/programs/${path} ${config.home.homeDirectory}/.config;
	'';
in
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
			DOCKER_HOST = "unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')";

			# Test containers
			TESTCONTAINERS_RYUK_DISABLED = "true";
			TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')";
		};

		activation = {
			symlinkActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
				${symlinkConfigDir "nvim" }
				${symlinkConfigDir "zellij" }
				${symlinkConfigDir "ghostty" }
				${symlinkConfigFile "starship/starship.toml" }
			'';
		};

	};

	programs.home-manager.enable = true;

}
