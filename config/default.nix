{ vars }: { home-manager, nix-homebrew, ... }:
let
	user = vars.personal.user;
	system = import ./system.nix { inherit vars; };
in
{
	imports = [
		system
		./brew.nix
		./window.nix
		./keyboard.nix
	];

	services.nix-daemon.enable = true;
	nixpkgs.hostPlatform = vars.personal.system;
	nix.settings = {
		trusted-users = [ user ];
		experimental-features = "nix-command flakes";
	};

	nix-homebrew = {
		user = user;
		enable = true;
		enableRosetta = true;
		autoMigrate = true;
	};

	users.users.${user}.home = vars.personal.home;
	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "bak";
		users.${user} = import ./home.nix;
	};

}
