{ user }: { home-manager, nix-homebrew, ... }:
{

  imports = [
    ./brew.nix
    ./system.nix
  ];

  services.nix-daemon.enable = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";

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