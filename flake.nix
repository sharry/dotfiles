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
		nix-rosetta-builder = {
			url = "github:cpick/nix-rosetta-builder";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		{
			self,
			nix-darwin,
			nix-homebrew,
			home-manager,
			nix-rosetta-builder,
			...
		}:
		let
			vars = import ./vars.nix;
			user = vars.personal.user;
			config = import ./config { inherit vars; };
		in
		{
			darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
				modules = [
					config
					home-manager.darwinModules.home-manager
					nix-homebrew.darwinModules.nix-homebrew
					nix-rosetta-builder.darwinModules.default
				];
			};

			darwinPackages = self.darwinConfigurations.${user}.pkgs;
		};
}
