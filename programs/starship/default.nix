{ config, vars, ... }:
{
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/starship/starship.toml";

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
