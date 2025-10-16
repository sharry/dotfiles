{
	homebrew = {

		enable = true;

		brews = [
			"nginx"
			"posting"
			"xcodegen"
		];

		taps = [
			"nikitabobko/tap"
		];

		casks = [
			"zen"
			"arc"
			"pika"
			"ngrok"
			"ghostty"
			"obsidian"
			"telegram"
			"aerospace"
			"desktoppr"
			"hiddenbar"
			"qbittorrent"
			# "blackhole-2ch" not used
		];

		onActivation = {
			upgrade = true;
			cleanup = "zap";
			autoUpdate = true;
		};
	};
}
