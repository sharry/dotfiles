{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd
    nil
    fzf
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
  ];
}
