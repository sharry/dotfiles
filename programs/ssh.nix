{ config, vars, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      Include ${config.sops.templates."ssh-whisper".path}
    '';

    matchBlocks = {
      "*" = {
        # Default values that were previously applied automatically
      };

      # Personal GitHub
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
        extraOptions = {
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
          IdentitiesOnly = "yes";
        };
      };

      # Work GitHub
      "github-work" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_work";
        extraOptions = {
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
          IdentitiesOnly = "yes";
        };
      };
    };
  };
}
