{
  imports = [
    ./yazi
    ./nvim
    ./btop
    ./zsh
    ./ghostty
    ./lazygit
    ./posting
    ./aerospace
    ./infisical
    ./opencode
    ./serpl
    ./starship
    ./ssh.nix
    ./git.nix
    ./direnv.nix
  ];

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  services.podman.enable = true;
}
