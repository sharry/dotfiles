{

  imports = [
    ../programs
  ];

  home = {

    stateVersion = "23.05";

    file = {
      ".config/aerospace/aerospace.toml".source = ../dotfiles/aerospace.toml;
      ".config/ghostty/config".source = ../dotfiles/ghostty;
      ".config/karabiner/karabiner.json".source = ../dotfiles/karabiner.json;
      ".config/lazygit/config.yml".source = ../dotfiles/lazygit.yml;
      ".ssh/config".source = ../dotfiles/ssh;
    };

    sessionVariables = {
      EDITOR = "code";
    };

  };

  programs.home-manager.enable = true;

}