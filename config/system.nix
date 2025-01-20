{ ... }:
let
	getWallpaperLink = name: "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/${name}.jpg";
in
{
	time.timeZone = "Africa/Casablanca";
	networking.localHostName = "bensadik";
	security.pam.enableSudoTouchIdAuth = true;
	system.stateVersion = 5;
	nixpkgs.config.allowUnfree = true;

	imports = [
		../programs/system-default.nix
	];

	system.activationScripts.postUserActivation.text = ''
		/usr/local/bin/desktoppr ${ getWallpaperLink "abandoned-trainstation" }
	'';

	system.defaults = {
		loginwindow.LoginwindowText = "youssef@bensadik.net";

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
