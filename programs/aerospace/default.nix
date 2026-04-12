{ config, vars, ... }:
{
  xdg.configFile."aerospace".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/aerospace";
}
