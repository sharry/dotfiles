{ config, vars, ... }:
let
  programsPath = "${vars.personal.dotfilesPath}/programs";
in
{
  xdg.configFile."posting".source = config.lib.file.mkOutOfStoreSymlink "${programsPath}/posting";

  home.file.".local/share/posting".source =
    config.lib.file.mkOutOfStoreSymlink "${programsPath}/posting/local";
}
