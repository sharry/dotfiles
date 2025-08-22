{
	description = "Sharry's Nix config";

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
	};

	outputs =
		{
			self,
			nix-darwin,
			nix-homebrew,
			home-manager,
			...
		}@inputs :
		let
			vars = import ./vars.nix;
			config = import ./config { inherit vars; inherit inputs; };
			user = vars.personal.user;
		in
		{
			darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
				modules = [
					config
					home-manager.darwinModules.home-manager
					nix-homebrew.darwinModules.nix-homebrew
				];
			};

			darwinPackages = self.darwinConfigurations.${user}.pkgs;
		};
}
