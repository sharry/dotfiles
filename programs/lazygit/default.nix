{ config, vars, ... }:
{
  xdg.configFile."lazygit".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/lazygit";
}
