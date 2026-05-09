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
      "pluk-inc/tap"
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
      "markdown-preview"
    ];

    onActivation = {
      upgrade = true;
      cleanup = "zap"; # Removes all formulae/casks not listed above
      autoUpdate = true;
    };
  };
}
