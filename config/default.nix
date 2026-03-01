{ vars, inputs }:
{ home-manager, nix-homebrew, ... }:
let
  user = vars.personal.user;
  system = import ./system.nix { inherit vars; };
in
{
  imports = [
    system
    ./brew.nix
    ./keyboard.nix
  ];

  nixpkgs.hostPlatform = vars.personal.system;
  nix.enable = false;
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
    extraSpecialArgs = { inherit inputs; };
    users.${user} = import ./home.nix;
    # Disable manual generation to avoid 'options.json' derivation warning
    sharedModules = [ { manual.manpages.enable = false; } ];
  };

}
