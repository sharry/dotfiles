{
	homebrew = {

		enable = true;

		brews = [
			"nginx"
			"yt-dlp"
			"ffmpeg"
			"posting"
			"xcodegen"
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
			"codexbar"
			"obsidian"
			"telegram"
			"aerospace"
			"desktoppr"
			"hiddenbar"
			"qbittorrent"
		];

		onActivation = {
			upgrade = true;
			cleanup = "zap";
			autoUpdate = true;
		};
	};
}
