{
	description = "Ben Sadik's Nix config";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvf = {
			url = "github:notashelf/nvf";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		{
		self,
		nix-darwin,
		nix-homebrew,
		home-manager,
		nvf,
		...
		}:
		let
			user = "momo";
			config = import ./config { inherit user; };
		in
		{
			darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
				modules = [
					config
					nvf.nixosModules.default
					nix-homebrew.darwinModules.nix-homebrew
					home-manager.darwinModules.home-manager
				];
			};

			darwinPackages = self.darwinConfigurations.${user}.pkgs;
		};
}
