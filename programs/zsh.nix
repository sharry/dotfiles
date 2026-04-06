{ pkgs, config, ... }:
let
  vars = import ../vars.nix;
  floatingCmd =
    title: cmd:
    "zellij run --floating --close-on-exit --name ${title} --width 90% --height 90% -x 5% -y 10% -- ${cmd}";
in
{
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";

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
      renix = "sudo --preserve-env=EMAIL,FULLNAME darwin-rebuild switch --flake ~/dotfiles#$USER --impure && { infisync || printf 'Warning: infisync failed\n'; } && exec zsh";
      freenix = "nix-collect-garbage -d";
      nixdev = "nix develop -c $SHELL";
      drag = "${vars.personal.dotfilesPath}/bin/drag";
      gz = "git archive -o \"$(basename \"$PWD\").zip\" HEAD";
      sr = floatingCmd "Serpl" "serpl";
      g = floatingCmd "Lazygit" "lazygit";
    };

    initContent = ''
            eval "$(/opt/homebrew/bin/brew shellenv)"

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

            load_infisical_machine_config() {
              local config_file="${config.xdg.configHome}/infisical/infisical.conf"

              if [ -f "$config_file" ]; then
                set -a
                . "$config_file"
                set +a
              fi
            }

            load_infisical_machine_env() {
              local env_file="${config.xdg.stateHome}/infisical/machine.env"

              if [ -f "$env_file" ]; then
                set -a
                . "$env_file"
                set +a
              fi
            }

            infisync() {
              emulate -L zsh
              setopt pipefail

              local config_file="${config.xdg.configHome}/infisical/infisical.conf"
              local state_dir="${config.xdg.stateHome}/infisical"
              local env_file="$state_dir/machine.env"
              local tmp_file="$env_file.tmp"
              local -a command

              mkdir -p "$state_dir"
              load_infisical_machine_config

              if [ -z "$INFISICAL_MACHINE_PROJECT_ID" ]; then
                printf 'Set INFISICAL_MACHINE_PROJECT_ID in %s\n' "$config_file"
                return 1
              fi

              command=(
                infisical export
                --silent
                --format=dotenv
                --projectId "$INFISICAL_MACHINE_PROJECT_ID"
                --env "''${INFISICAL_MACHINE_ENV:-macbook}"
                --path "''${INFISICAL_MACHINE_PATH:-/}"
              )

              if [ -n "$INFISICAL_MACHINE_DOMAIN" ]; then
                command+=(--domain "$INFISICAL_MACHINE_DOMAIN")
              fi

              if [ -n "$INFISICAL_MACHINE_TOKEN" ]; then
                command+=(--token "$INFISICAL_MACHINE_TOKEN")
              fi

              if ! "$command[@]" >| "$tmp_file"; then
                rm -f "$tmp_file"
                return 1
              fi

              chmod 600 "$tmp_file"
              mv "$tmp_file" "$env_file"
              load_infisical_machine_env
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
              [[ $ZELLIJ == 1 ]] || return 0

              local current_dir=$PWD
              if [[ $current_dir == $HOME ]]; then
                current_dir="~"
              else
                current_dir=''${current_dir##*/}
              fi

              command nohup zellij action rename-tab "$current_dir" >/dev/null 2>&1 &!
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

            # Calculate opencode port based on git repo or current directory
            opencode_port() {
              # Check if in a git submodule first
              local superproject=$(git rev-parse --show-superproject-working-tree 2>/dev/null)

              if [ -n "$superproject" ]; then
                # In a submodule - use parent repo's .git
                local git_dir=$(cd "$superproject" && git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null)
              else
                # Normal git repo
                local git_dir=$(git rev-parse --git-dir 2>/dev/null | xargs realpath 2>/dev/null)
              fi

              if [ -n "$git_dir" ]; then
                # Hash the .git directory path
                echo $((0x$(echo -n "$git_dir" | md5 | cut -c1-8) % 10000 + 50000))
              else
                # Fallback: hash current directory path
                echo $((0x$(echo -n "$PWD" | md5 | cut -c1-8) % 10000 + 50000))
              fi
            }

            # Export port as environment variable for nvim
            export_opencode_port() {
              export OPENCODE_PORT=$(opencode_port)
            }

            o() {
              local port=$(opencode_port)
              opencode --port "$port"
            }

            load_infisical_machine_config
            load_infisical_machine_env
            export_opencode_port
            zellij_tab_name_update
            chpwd_functions+=(export_opencode_port zellij_tab_name_update)
    '';
  };
}
