{
  imports = [
    ./pkgs.nix
    ./secrets.nix
    ../programs
  ];

  xdg.enable = true;

  home = {
    file.".hushlogin".text = "";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
