{
  pkgs,
  config,
  vars,
  ...
}:
let
  floatingCmd =
    title: cmd:
    "zellij run --floating --close-on-exit --name ${title} --width 90% --height 90% -x 5% -y 10% -- ${cmd} >/dev/null";

  # Read and interpolate shell function files
  readFunc = file: builtins.readFile file;
  interpolateInfisical =
    builtins.replaceStrings
      [ "@configHome@" "@stateHome@" ]
      [ config.xdg.configHome config.xdg.stateHome ]
      (readFunc ./functions/infisical.sh);
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
      renix = "sudo darwin-rebuild switch --flake ~/dotfiles#$USER && { infisync || printf 'Warning: infisync failed\\n'; } && exec zsh";
      freenix = "nix-collect-garbage -d";
      nixdev = "nix develop -c $SHELL";
      drag = "${vars.personal.dotfilesPath}/bin/drag";
      gz = "git archive -o \"$(basename \"$PWD\").zip\" HEAD";
      sr = floatingCmd "Serpl" "serpl";
      g = floatingCmd "Lazygit" "lazygit";
    };

    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      ${readFunc ./functions/utils.sh}
      ${interpolateInfisical}
      ${readFunc ./functions/zellij.sh}
      ${readFunc ./functions/opencode.sh}

      load_infisical_machine_config
      load_infisical_machine_env
      typeset -gaU chpwd_functions
      chpwd_functions+=(export_opencode_port zellij_tab_name_update)
    '';
  };
}
