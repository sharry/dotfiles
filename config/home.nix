{

  imports = [
    ../programs/zsh.nix
    ../programs/git.nix
    ../programs/zoxide.nix
    ../programs/direnv.nix
  ];

  home = {

    stateVersion = "23.05";

    file = {
      ".config/aerospace/aerospace.toml".source = ../dotfiles/aerospace.toml;
      ".config/ghostty/config".source = ../dotfiles/ghostty;
      ".config/yazi/yazi.toml".source = ../dotfiles/yazi.toml;
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
