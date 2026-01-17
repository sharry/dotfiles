{ config, lib, ... }:
let
	vars = import ../vars.nix;
	symlinkConfigDir = directory: ''
		run ln --symbolic --force --no-dereference $VERBOSE_ARG ${vars.personal.dotfilesPath}/programs/${directory} ${config.xdg.configHome}/${directory};
	'';
	symlinkLocalDir = directory: ''
		run ln --symbolic --force --no-dereference $VERBOSE_ARG ${vars.personal.dotfilesPath}/programs/${directory}/local ${vars.personal.home}/.local/share/${directory};
	'';
	symlinkConfigFile = path: configDir: ''
		run ln --symbolic --force --no-dereference $VERBOSE_ARG ${vars.personal.dotfilesPath}/programs/${path} ${config.xdg.configHome}${configDir};
	'';
in
{

	imports = [
		./pkgs.nix
		../programs 
	];

	xdg.enable = true;

	home = {

		file.".hushlogin".text = ""; # Stops showing the "last login" message

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
				${symlinkConfigDir "btop"}
				${symlinkConfigDir "yazi"}
				${symlinkConfigDir "nvim"}
				${symlinkConfigDir "serpl"}
				${symlinkConfigDir "zellij"}
				${symlinkConfigDir "ghostty"}
				${symlinkConfigDir "lazygit"}
				${symlinkConfigDir "posting"}
				${symlinkLocalDir "posting"}
				${symlinkConfigDir "aerospace"}
				${symlinkConfigFile "starship/starship.toml" ""}
				${symlinkConfigFile "opencode/opencode.json" "/opencode"}
			'';
		};

	};

	programs.home-manager.enable = true;

}
