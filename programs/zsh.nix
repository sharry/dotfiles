{ pkgs, ... }:
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
	  g = "lazygit";
      ll = "ls -l";
      renix = "darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
    };

  };
}
