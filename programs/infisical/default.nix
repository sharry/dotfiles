{ config, vars, ... }:
{
  xdg.configFile."infisical".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/infisical";
}
