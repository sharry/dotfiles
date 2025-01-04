{
  time.timeZone = "Africa/Casablanca";
  networking.localHostName = "bensadik";
  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 5;

  system.defaults = {
    loginwindow.LoginwindowText = "youssef@bensadik.net";

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };

    dock = {
      autohide = true;
      persistent-apps = [ ];
      orientation = "right";
      minimize-to-application = true;
      wvous-br-corner = 1; # Disable buttom right Hot Corner
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
        KeyboardShortcuts_popup = ''{"carbonKeyCode":9,"carbonModifiers":768}'';
        searchVisibility = "duringSearch";
      };
    };
  };
}
