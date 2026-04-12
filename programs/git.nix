{ config, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      { inherit (config.sops.templates."gitconfig-user") path; }
    ];
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519_personal.pub";
      signByDefault = true;
    };
    settings = {
      pull.rebase = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      tag.gpgSign = true;
    };
    ignores = [
      ".DS_Store"
      "*.*~"
    ];
  };
}
