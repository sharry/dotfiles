{
  homebrew = {
    enable = true;

    taps = [
      # "nikitabobko/tap"
    ];

    casks = [
      "arc"
      "pika"
      "maccy"
      "ghostty"
      "obsidian"
      "telegram"
      # "aerospace"
      "hiddenbar"
      "fsmonitor"
      "microsoft-edge"
      "karabiner-elements"
      "visual-studio-code"
    ];

    # App Store apps
    # Syntax: <app-name: string> = <app-id: number>;
    masApps = {

    };

    onActivation = {
      upgrade = true;
      cleanup = "zap";
      autoUpdate = true;
    };
  };
}
