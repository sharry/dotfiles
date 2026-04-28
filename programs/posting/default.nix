{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  programsPath = "${vars.personal.dotfilesPath}/programs";
  syncPostingTheme = pkgs.writeShellScript "sync-posting-theme" (
    builtins.replaceStrings [ "@dataHome@" ] [ config.xdg.dataHome ] (builtins.readFile ./sync-theme.sh)
  );
in
{
  xdg.configFile."posting".source = config.lib.file.mkOutOfStoreSymlink "${programsPath}/posting";

  home.activation.migratePostingDataDir = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    posting_dir="${config.home.homeDirectory}/.local/share/posting"

    if [ -L "$posting_dir" ]; then
      posting_target="$(readlink "$posting_dir" || true)"

      case "$posting_target" in
        /nix/store/*-home-manager-files/.local/share/posting)
          rm -f "$posting_dir"
          mkdir -p "$posting_dir/themes"
          ;;
      esac
    fi
  '';

  home.file.".local/share/posting/themes/catppuccin-latte.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${programsPath}/posting/local/themes/catppuccin-latte.yml";

  home.file.".local/share/posting/themes/catppucin-mocha.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${programsPath}/posting/local/themes/catppucin-mocha.yml";

  home.activation.postingAutoTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${syncPostingTheme}
  '';

  launchd.agents.posting-theme-sync = {
    enable = true;
    config = {
      ProgramArguments = [ "${syncPostingTheme}" ];
      RunAtLoad = true;
      WatchPaths = [ "${vars.personal.home}/Library/Preferences/.GlobalPreferences.plist" ];
    };
  };
}
