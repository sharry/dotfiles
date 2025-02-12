{ config, lib, ... }:
let
	symlink = sourceFolder: targertFolder: ''
		run ln --symbolic --force $VERBOSE_ARG ${config.home.homeDirectory}/dotfiles/programs/${sourceFolder} ${config.home.homeDirectory}/.config/${targertFolder};
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
				${symlink "neovim" "nvim"}
			'';
		};

	};

	programs.home-manager.enable = true;

}
