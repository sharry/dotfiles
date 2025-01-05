{

  imports = [
    ./pkgs.nix
    ../programs
  ];

  home = {

    stateVersion = "23.05";

    file = {
      ".config/aerospace/aerospace.toml".source = ../dotfiles/aerospace.toml;
      ".ssh/config".source = ../dotfiles/ssh;
    };

    sessionVariables = {
      EDITOR = "code";
    };

  };

  programs.home-manager.enable = true;

}