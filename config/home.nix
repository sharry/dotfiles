{ pkgs, ... }:
{

  home.stateVersion = "23.05";

  imports = [
    ../programs/zsh.nix
    ../programs/git.nix
  ];

  programs = {

    java = {
      enable = true;
      package = pkgs.jdk17;
    };

    home-manager = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

  };

  home = {

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

}
