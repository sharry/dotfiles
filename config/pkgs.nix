{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    nil
    fzf
    atac
    deno
    xclip
    gnupg
    ffmpeg
    lazygit
    ripgrep
    nodejs_22
    imagemagick
    nixfmt-rfc-style
  ];
}
