{ config, vars, ... }:
let
  programsPath = "${vars.personal.dotfilesPath}/programs";
in
{
  programs.btop.enable = true;
  xdg.configFile."btop".source = config.lib.file.mkOutOfStoreSymlink "${programsPath}/btop";
}
