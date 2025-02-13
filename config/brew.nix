{
	homebrew = {

		enable = true;

		brews = [
			"posting"
		];

		casks = [
			"arc"
			"pika"
			"maccy"
			"raycast"
			"ghostty"
			"obsidian"
			"telegram"
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
