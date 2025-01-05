{ pkgs, ... }:
{
  programs.zsh = {

    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      v = "nvim";
      c = "clear";
      y = "yazi";
      ll = "ls -l";
      renix = "darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    initExtra = ''
      source ~/.p10k.zsh
    '';

  };
}
