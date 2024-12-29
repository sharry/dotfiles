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
			fd
			fzf
			deno
			yazi
			xclip
			ffmpeg
			neovim
			lazygit
			ripgrep
			nodejs_22
			imagemagick
		];

		time.timeZone = "Africa/Casablanca";

		services = {
			nix-daemon.enable = true;
		};

		system.stateVersion = 5;
		nixpkgs.hostPlatform = "aarch64-darwin";
		security.pam.enableSudoTouchIdAuth = true;     
		nix.settings.experimental-features = "nix-command flakes";
      	system.configurationRevision = self.rev or self.dirtyRev or null;

		system.defaults = {
			finder = {
				AppleShowAllFiles = true;
				AppleShowAllExtensions = true;
			};
			
			dock = {
				autohide = true;
				persistent-apps = [];
				orientation = "right";
				minimize-to-application = true;
			};

			NSGlobalDomain = {
				KeyRepeat = 2;
				AppleMetricUnits = 1;
				AppleInterfaceStyle = "Dark";
				AppleICUForce24HourTime = true;
				AppleTemperatureUnit = "Celsius";
				AppleMeasurementUnits = "Centimeters";
				NSDocumentSaveNewDocumentsToCloud = false;
			};

			CustomUserPreferences = {
				"org.p0deje.Maccy" = {
					ignoredApps = [
						"com.apple.Passwords"
					];
					menuIcon = "paperclip";
					pasteByDefault = true;
					showFooter = false;
					showTitle = false;
					KeyboardShortcuts_popup = ''{"carbonKeyCode":9,"carbonModifiers":768}'';
					searchVisibility = "duringSearch";
				};
			};	
		};

		homebrew = {
			enable = true;

			taps = [
				"nikitabobko/tap"
			];

			casks = [
				"arc"
				"maccy"
				"ghostty"
				"obsidian"
				"aerospace"
				"hiddenbar"
				"microsoft-edge"
				"visual-studio-code"
			];

			brews = [];

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
						backupFileExtension = "bak";
						users."${user}" = import ./home.nix;
					};
				}
			];
		};

		darwinPackages = self.darwinConfigurations.sharry.pkgs;
	};
}
