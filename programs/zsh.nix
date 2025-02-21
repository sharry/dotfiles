{ pkgs, ... }:
{
	programs.zsh = {

		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		plugins = [
			{
				name = "vi-mode";
				src = pkgs.zsh-vi-mode;
				file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
			}
		];

		shellAliases = {
			x = "exit";
			v = "nvim";
			c = "clear";
			y = "yazi";
			g = "lazygit";
			ll = "ls -l";
			db = "lazysql";
			pod = "lazydocker";
			stats = "btop";
			docker = "podman";
			unjwt = "jwt decode $(pbpaste)";
			renix = "darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
			freenix = "nix-collect-garbage -d";
			nixdev = "nix develop -c $SHELL";
		};

		initExtra = ''
			 macos_theme() {
				if [[ $(defaults read ~/Library/Preferences/.GlobalPreferences.plist  AppleInterfaceStyle 2>/dev/null) = Dark ]]; then
					echo 'Dark'
				else
					echo 'Light'
				fi
			}
		'';
	};
}
