{
	description = "Ben Sadik's Nix config";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
	let
	configuration = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			fd
			nil
			fzf
			deno
			yazi
			xclip
			gnupg
			ffmpeg
			neovim
			lazygit
			ripgrep
			nodejs_22
			imagemagick
		];

		services = {
			nix-daemon.enable = true;
		};

		networking = {
			localHostName = "bensadik";
		};

		nixpkgs.hostPlatform = "aarch64-darwin";
		security.pam.enableSudoTouchIdAuth = true;     
		nix.settings.experimental-features = "nix-command flakes";

	};
	user = "momo";
	in
	{
		darwinConfigurations."sharry" = nix-darwin.lib.darwinSystem {
			modules = [
				./system.nix
				./brew.nix
				configuration
				nix-homebrew.darwinModules.nix-homebrew
				{
					nix-homebrew = {
						enable = true;
						enableRosetta = true;
						user = user;
						autoMigrate = true;
				 	};
				}

				home-manager.darwinModules.home-manager
        {
					users.users.${user}.home = "/Users/${user}";
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						backupFileExtension = "bak";
						users.${user} = import ./home.nix;
					};
				}
			];
		};

		darwinPackages = self.darwinConfigurations.sharry.pkgs;
	};
}
