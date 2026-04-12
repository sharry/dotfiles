{ config, vars, ... }:
let
  sshDir = "${vars.personal.home}/.ssh";
  sshSecret = fileName: mode: {
    path = "${sshDir}/${fileName}";
    inherit mode;
  };
in
{
  sops = {
    age.keyFile = "${vars.personal.home}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;

    secrets = {
      email = { };
      fullname = { };
      whisper_hostname = { };
      ssh_id_ed25519_personal = sshSecret "id_ed25519_personal" "0600";
      ssh_id_ed25519_personal_pub = sshSecret "id_ed25519_personal.pub" "0644";
      ssh_id_ed25519_work = sshSecret "id_ed25519_work" "0600";
      ssh_id_ed25519_work_pub = sshSecret "id_ed25519_work.pub" "0644";
      ssh_id_ed25519_secure = sshSecret "id_ed25519_secure" "0600";
      ssh_id_ed25519_secure_pub = sshSecret "id_ed25519_secure.pub" "0644";
    };

    templates = {
      "gitconfig-user".content = ''
        [user]
          email = ${config.sops.placeholder.email}
          name = ${config.sops.placeholder.fullname}
      '';

      "ssh-whisper".content = ''
        Host whisper
          HostName ${config.sops.placeholder.whisper_hostname}
          User whisper
          IdentityFile ~/.ssh/id_ed25519_secure
          IdentitiesOnly yes
          SendEnv SSH_ZJ_SESSION
      '';
    };
  };
}
