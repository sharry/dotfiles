{
  homebrew = {

    enable = true;

    brews = [
      "nginx"
      "sheets"
      "yt-dlp"
      "ffmpeg"
      "posting"
      "xcodegen"
    ];

    taps = [
      "steipete/tap"
      "nikitabobko/tap"
    ];

    casks = [
      "arc"
      "iina"
      "pika"
      "ngrok"
      "ghostty"
      "obsidian"
      "telegram"
      "aerospace"
      "desktoppr"
      "hiddenbar"
      "secretive"
      "qbittorrent"
    ];

    onActivation = {
      upgrade = true;
      cleanup = "zap"; # Removes all formulae/casks not listed above
      autoUpdate = true;
    };
  };
}
