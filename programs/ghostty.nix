{ ... }:
let
  configPath = ".config/ghostty/config";
in
{
  home.file.${configPath}.text = ''
    theme = dark:catppuccin-mocha,light:catppuccin-latte
    mouse-hide-while-typing = true
    background-blur-radius = 20
    background-opacity = 0.95
    window-decoration = true
  '';
}