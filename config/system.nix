{ vars }: { ... }:
{
	time.timeZone = "Africa/Casablanca";
	networking.localHostName = "bensadik";
	security.pam.services.sudo_local.touchIdAuth = true;
	system = {
		stateVersion = 5;
		primaryUser = vars.personal.user;
	};
	nixpkgs.config = {
		allowUnfree = true;
		allowUnsupportedSystem = true;
	};

	imports = [
		../programs/system-default.nix
	];

	system.activationScripts.activateSettings.text = ''
		/usr/local/bin/desktoppr ${vars.personal.dotfilesPath}/assets/catppuccin-wallpaper.heic
	'';
	system.defaults = {
		loginwindow.LoginwindowText = vars.personal.email;

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
			".GlobalPreferences"= {
				NSAutomaticTextReplacementEnabled = 1;
				NSUserDictionaryReplacementItems = [
					{ on = 1; replace = ";t"; "with" = "Translate the following text to English:"; }
					{ on = 1; replace = ";r"; "with" = "Rewrite the following text, keep the language simple and the idea clear:"; }
				];
			};
		};
	};
}
