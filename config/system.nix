{
  time.timeZone = "Africa/Casablanca";
  networking.localHostName = "bensadik";
  security.pam.enableSudoTouchIdAuth = true;
  system.stateVersion = 5;

  imports = [
    ../programs/system-default.nix
  ];

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
    
  };
}
