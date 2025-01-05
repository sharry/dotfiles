{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = pkgs.lib.importTOML ../dotfiles/starship.toml;
  };
}