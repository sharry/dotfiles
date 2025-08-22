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
			"maccy"
			"raycast"
			"ghostty"
			"obsidian"
			"telegram"
			"kindavim"
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
