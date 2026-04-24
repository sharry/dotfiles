{ vars }:
{ pkgs, ... }:
{
  time.timeZone = "Africa/Casablanca";
  networking.localHostName = "bensadik";
  security.pam.services.sudo_local.touchIdAuth = true;
  fonts.packages = with pkgs; [
    ibm-plex
    nerd-fonts.jetbrains-mono
  ];
  system = {
    stateVersion = 5;
    primaryUser = vars.personal.user;
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  system.activationScripts.activateSettings.text = ''
    if command -v desktoppr &>/dev/null; then
      desktoppr ${vars.personal.dotfilesPath}/assets/catppuccin-wallpaper.heic
    fi
  '';

  # Decrypt login window text from sops at activation time (runs as root)
  system.activationScripts.loginwindowText.text =
    let
      sopsFile = ../secrets/secrets.yaml;
      ageKeyFile = "${vars.personal.home}/.config/sops/age/keys.txt";
      inherit (vars.personal) user;
      inherit (vars.personal) home;
    in
    ''
      if [ -s "${ageKeyFile}" ]; then
        if email=$(sudo -u "${user}" env HOME="${home}" SOPS_AGE_KEY_FILE="${ageKeyFile}" ${pkgs.sops}/bin/sops decrypt --extract '["email"]' "${sopsFile}" 2>/dev/null); then
          if [ -n "$email" ]; then
            defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "$email"
          else
            defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText 2>/dev/null || true
          fi
        else
          printf '%s\n' "Failed to decrypt login window text from ${sopsFile}" >&2
          defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText 2>/dev/null || true
        fi
      else
        defaults delete /Library/Preferences/com.apple.loginwindow LoginwindowText 2>/dev/null || true
      fi
    '';

  system.defaults = {

    dock = {
      autohide = true;
      persistent-apps = [ ];
      orientation = "right";
      minimize-to-application = true;
      wvous-br-corner = 1; # Disable bottom right Hot Corner
    };

    finder = {
      CreateDesktop = false;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      AppleMetricUnits = 1;
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      AppleTemperatureUnit = "Celsius";
      AppleMeasurementUnits = "Centimeters";
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    CustomUserPreferences = {
      ".GlobalPreferences" = {
        NSAutomaticTextReplacementEnabled = 1;
        NSUserDictionaryReplacementItems = [
          {
            on = 1;
            replace = ";t";
            "with" = "Translate the following text to English:";
          }
          {
            on = 1;
            replace = ";r";
            "with" = "Rewrite the following text, keep the language simple and the idea clear:";
          }
        ];
      };

      "com.apple.screencapture" = {
        target = "clipboard";
      };

      "org.p0deje.Maccy" = {
        ignoredApps = [
          "com.apple.Passwords"
          "org.keepassxc.keepassxc"
        ];
        menuIcon = "paperclip";
        pasteByDefault = true;
        showFooter = false;
        showTitle = false;
        KeyboardShortcuts_popup = ''{"carbonKeyCode":9,"carbonModifiers":768}''; # Cmd+Shift+V
        searchVisibility = "duringSearch";
      };

      "com.superhighfives.Pika" = {
        KeyboardShortcuts_togglePika = ''{"carbonKeyCode":8,"carbonModifiers":768}''; # Command+Shift+C
        LaunchAtLogin__hasMigrated = true;
        copyColorOnPick = true;
        viewedSplash = true;
        colorFormat = "Hex";
      };
    };
  };
}
