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
			"arc"
			"pika"
			"maccy"
			"raycast"
			"ghostty"
			"obsidian"
			"telegram"
			"aerospace"
			"desktoppr"
			"hiddenbar"
			"blackhole-2ch"
			"visual-studio-code"
		];

		onActivation = {
			upgrade = true;
			cleanup = "zap";
			autoUpdate = true;
		};
	};
}
