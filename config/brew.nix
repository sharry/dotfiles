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
      "zen@twilight"
      "iina"
      "pika"
      "ghostty"
      "obsidian"
      "telegram"
      "aerospace"
      "desktoppr"
      "hiddenbar"
      "secretive"
      "qbittorrent"
      "tablepro"
    ];

    onActivation = {
      upgrade = true;
      cleanup = "zap"; # Removes all formulae/casks not listed above
      autoUpdate = true;
    };
  };
}
