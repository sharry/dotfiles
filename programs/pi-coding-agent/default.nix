{ config, vars, ... }:
let
  piPath = "${vars.personal.dotfilesPath}/programs/pi-coding-agent";
in
{
  home.file.".pi/agent/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${piPath}/settings.json";

  home.file.".pi/agent/theme-sync.json".source =
    config.lib.file.mkOutOfStoreSymlink "${piPath}/theme-sync.json";
}
