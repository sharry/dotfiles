{
  config,
  pkgs,
  vars,
  ...
}:
let
  opencodePatched = pkgs.opencode.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./transparent-background.patch ];
  });
in
{
  home.packages = [ opencodePatched ];

  xdg = {
    configFile = {
      "opencode/opencode.json".source =
        config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/opencode/opencode.json";
      "opencode/tui.json".source =
        config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/opencode/tui.json";
      "opencode/themes".source =
        config.lib.file.mkOutOfStoreSymlink "${vars.personal.dotfilesPath}/programs/opencode/themes";
    };
  };
}
