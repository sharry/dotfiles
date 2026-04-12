{ config, vars, ... }:
{
  xdg.configFile."ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/ghostty";
}
