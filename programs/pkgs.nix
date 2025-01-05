{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    nil
    fzf
    atac
    deno
    yazi
    xclip
    gnupg
    ffmpeg
    neovim
    lazygit
    ripgrep
    nodejs_22
    imagemagick
    nixfmt-rfc-style
    zsh-powerlevel10k
  ];
}
