{
	homebrew = {

		enable = true;

		brews = [
			"nginx" # <- To Delete
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
