{ config, vars, ... }:
{
  # xdg.configFile."zellij".source =
  #   config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/zellij";

  programs.zellij = {
    enable = false;
    enableZshIntegration = false;
  };
}
