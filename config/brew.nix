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
			"sloth"
			"raycast"
			"ghostty"
			"obsidian"
			"telegram"
			"desktoppr"
			"hiddenbar"
			"fsmonitor"
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
