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

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {

          services.nix-daemon.enable = true;
          nixpkgs.hostPlatform = "aarch64-darwin";
          nix.settings.experimental-features = "nix-command flakes";

        };
      user = "momo";
    in
    {
      darwinConfigurations."sharry" = nix-darwin.lib.darwinSystem {
        modules = [
          ./config/pkgs.nix
          ./config/system.nix
          ./config/brew.nix
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              inherit user;
              enable = true;
              enableRosetta = true;
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
              users.${user} = import ./config/home.nix;
            };
          }
        ];
      };

      darwinPackages = self.darwinConfigurations.sharry.pkgs;
    };
}
