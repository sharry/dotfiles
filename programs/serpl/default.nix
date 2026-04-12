{ config, vars, ... }:
{
  xdg.configFile."serpl".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/serpl";
}
