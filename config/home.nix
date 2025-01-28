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

	};

	programs.home-manager.enable = true;

}
