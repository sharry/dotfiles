{
	description = "Ben Sadik's Nix config";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nix-darwin.url = "github:LnL7/nix-darwin";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
	let
	configuration = { pkgs, ... }: {
		environment.systemPackages = with pkgs; [
			vim
			yazi
			neovim
			lazygit
			nodejs_22
		];

		services = {
			nix-daemon.enable = true;
		};

		nix.settings.experimental-features = "nix-command flakes";
      	programs.zsh.enable = true;
      	system.configurationRevision = self.rev or self.dirtyRev or null;
		system.stateVersion = 5;
		nixpkgs.hostPlatform = "aarch64-darwin";
		security.pam.enableSudoTouchIdAuth = true;     

		system.defaults = {
			finder = {
				AppleShowAllExtensions = true;
				AppleShowAllFiles = true;
			};
			dock = {
				autohide = true;
				minimize-to-application = true;
				orientation = "right";
				persistent-apps = [];
			};
			NSGlobalDomain = {
				AppleInterfaceStyle = "Dark";
				AppleICUForce24HourTime = true;
				KeyRepeat = 2;
			};
		};

		homebrew = {
			enable = true;

			taps = [
				"nikitabobko/tap"
			];

			casks = [
				"arc"
				"aerospace"
				"hiddenbar"
				"microsoft-edge"
				"visual-studio-code"
				"obsidian"
				"ghostty"
			];

			brews = [
				"deno"
				"ffmpeg"
				"sevenzip"
				"poppler"
				"fd"
				"ripgrep"
				"fzf"
				"imagemagick"
				"xclip"
			];

			onActivation = { 
				upgrade = true;
				cleanup = "zap";
				autoUpdate = true;
			};
		};
	};
	user = "momo";
	in
	{
		darwinConfigurations.sharry = nix-darwin.lib.darwinSystem {
			modules = [
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
					users.users."${user}".home = "/Users/${user}";
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						backupFileExtension = "backup";
						users."${user}" = import ./home.nix;
					};
				}
			];
		};

		darwinPackages = self.darwinConfigurations.sharry.pkgs;
	};
}
