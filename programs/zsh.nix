{ ... }:
{
  programs.zsh = {

    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

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

  };
}
