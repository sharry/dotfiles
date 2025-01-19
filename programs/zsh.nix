{
	programs.zsh = {

		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			v = "nvim";
			c = "clear";
			y = "yazi";
			g = "lazygit";
			ll = "ls -l";
			db = "lazysql";
			pod = "lazydocker";
			stats = "btop";
			unjwt = "jwt decode $(pbpaste)";
			renix = "darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
			freenix = "nix-collect-garbage -d";
			nixdev = "nix develop -c $SHELL";
		};

	};
}
