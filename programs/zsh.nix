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
			d = "npx ccr code";
			e = "zellij action edit-scrollback";
			db = "lazysql";
			pod = "lazydocker";
			stats = "btop";
			docker = "podman";
			neofetch = "fastfetch";
			renix = "sudo darwin-rebuild switch --flake ~/dotfiles#$USER && source ~/.zshrc";
			freenix = "nix-collect-garbage -d";
			nixdev = "nix develop -c $SHELL";
			gz = "git archive -o \"$(basename \"$PWD\").zip\" HEAD";
			sr = floatingCmd "Serpl" "serpl";
			g = floatingCmd "Lazygit" "lazygit";
		};

		initContent = ''
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
				local header=$(echo "$output" | awk 'c==1{print} /^----/{c++}' | tail -r | tail -n +4 | tail -r)
				local claims=$(echo "$output" | awk 'c==2{print} /^----/{c++}')
				echo "$header" | jq
				echo
				echo "$claims" | jq
			}

			zellij_tab_name_update() {
				if [[ -n $ZELLIJ ]]; then
					local current_dir=$PWD
					if [[ $current_dir == $HOME ]]; then
						current_dir="~"
					else
						current_dir=''${current_dir##*/}
					fi
					command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
				fi
			}

			killport() {
				if [ -z "$1" ]; then
					echo "Usage: killport <port>"
					return 1
				fi

				PORT=$1
				if command -v lsof > /dev/null; then
					PID=$(lsof -i tcp:"$PORT" -sTCP:LISTEN -t 2>/dev/null)
				else
					echo "lsof not found. Please install lsof."
					return 1
				fi

				if [ -z "$PID" ]; then
					echo "No process found on port $PORT"
				else
					echo "Killing process $PID on port $PORT"
					kill -9 "$PID"
				fi
			}

			zellij_tab_name_update
			chpwd_functions+=(zellij_tab_name_update)

			export FZF_DEFAULT_OPTS='
				--color=bg+:16,spinner:4,hl:4,border:4
				--color=fg:19,header:2,info:4,pointer:4
				--color=marker:4,fg+:19,prompt:4,hl+:2
			'
		'';
	};
}
