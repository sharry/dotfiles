{
  config,
  pkgs,
  vars,
  ...
}:
let
  inherit (vars.personal.secretive) socket signingPubKey;
  secretiveSshKeygen = pkgs.writeShellScript "secretive-ssh-keygen" ''
    export SSH_AUTH_SOCK="${socket}"
    exec ${pkgs.openssh}/bin/ssh-keygen "$@"
  '';
in
{
  programs.git = {
    enable = true;
    includes = [
      { inherit (config.sops.templates."gitconfig-user") path; }
    ];
    signing = {
      format = "ssh";
      key = signingPubKey;
      signByDefault = true;
    };
    settings = {
      pull.rebase = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      tag.gpgSign = true;
      gpg.ssh.program = "${secretiveSshKeygen}";
    };
    ignores = [
      ".DS_Store"
      "*.*~"
    ];
  };
}
