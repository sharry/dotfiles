{
	homebrew = {

		enable = true;

		brews = [
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
			"microsoft-edge"
			"visual-studio-code"
		];

		onActivation = {
			upgrade = true;
			cleanup = "zap";
			autoUpdate = true;
		};
	};
}
