{

  imports = [
    ./pkgs.nix
    ../programs
  ];

  home = {

    stateVersion = "23.05";

    sessionVariables = {
      EDITOR = "code";
    };

  };

  programs.home-manager.enable = true;

}