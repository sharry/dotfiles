{ pkgs, ... }:
let
	floatingCmd = title: cmd: "zellij run --floating --close-on-exit --name ${title} --width 90% --height 90% -x 5% -y 10% -- ${cmd}";
in
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
			e = "zellij action edit-scrollback";
			db = "lazysql";
			pod = "lazydocker";
			stats = "btop";
			docker = "podman";
			neofetch = "fastfetch";
			renix = "darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
			freenix = "nix-collect-garbage -d";
			nixdev = "nix develop -c $SHELL";
			sr = floatingCmd "Serpl" "serpl";
			g = floatingCmd "Lazygit" "lazygit";
		};

		initExtra = ''
			 function macos_theme() {
				if [[ $(defaults read ~/Library/Preferences/.GlobalPreferences.plist  AppleInterfaceStyle 2>/dev/null) = Dark ]]; then
					echo 'Dark'
				else
					echo 'Light'
				fi
			}

			function y() {
				local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
				yazi "$@" --cwd-file="$tmp"
				if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
					builtin cd -- "$cwd"
				fi
				rm -f -- "$tmp"
			}

			function unjwt() {
				local output=$(jwt decode $(pbpaste))
				# local header=$(echo "$output" | awk 'c==1{print} /^----/{c++}' | tail -r | tail -n +4 | tail -r)
				local claims=$(echo "$output" | awk 'c==2{print} /^----/{c++}')
				echo "$claims" | jq
			}

			if [[ ! -v FASTFETCH_SHOWN ]]; then
				fastfetch
				export FASTFETCH_SHOWN=1
			fi
		'';
	};
}
