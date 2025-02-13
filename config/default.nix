{ user }: { home-manager, nix-homebrew, ... }:
let
	system = "aarch64-darwin";
in
{

	imports = [
		./brew.nix
		./system.nix
		./window.nix
		./keyboard.nix
	];

	services.nix-daemon.enable = true;
	nixpkgs.hostPlatform = system;
	nix.settings = {
		trusted-users = [ user ];
		experimental-features = "nix-command flakes";
	};

	nix-homebrew = {
		inherit user;
		enable = true;
		enableRosetta = true;
		autoMigrate = true;
	};

	users.users.${user}.home = "/Users/${user}";
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "bak";
		users.${user} = import ./home.nix;
	};

}
