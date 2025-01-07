{
	homebrew = {

		enable = true;

		casks = [
			"arc"
			"pika"
			"maccy"
			"ghostty"
			"obsidian"
			"telegram"
			"hiddenbar"
			"fsmonitor"
			"microsoft-edge"
			"karabiner-elements" # TODO: migrate to nix keymapper
			"visual-studio-code"
		];

		onActivation = {
			upgrade = true;
			cleanup = "zap";
			autoUpdate = true;
		};
	};
}
