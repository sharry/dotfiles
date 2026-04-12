{
  homebrew = {

    enable = true;

    brews = [
      "nginx"
      "yt-dlp"
      "ffmpeg"
      "posting"
      "xcodegen"
      "cf-terraforming"
      "anomalyco/tap/opencode"
    ];

    taps = [
      "steipete/tap"
      "nikitabobko/tap"
    ];

    casks = [
      "zen"
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
      "qbittorrent"
    ];

    onActivation = {
      upgrade = true;
      cleanup = "zap"; # Removes all formulae/casks not listed above
      autoUpdate = true;
    };
  };
}
