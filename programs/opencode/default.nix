{ config, vars, ... }:
{
  xdg.configFile."opencode/opencode.json".source =
    config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/opencode/opencode.json";
}
