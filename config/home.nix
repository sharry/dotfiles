{ pkgs, ... }:
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
			DOCKER_HOST = "unix:///var/folders/fq/5f3z4_ws52q9m_dg86zp0mp40000gn/T/podman/podman-machine-default-api.sock";
		};

	};

	programs.home-manager.enable = true;

}
