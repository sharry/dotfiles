{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.twilight ];

  programs.zen-browser = lib.mkMerge [
    {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DisablePocket = true;
      };
      setAsDefaultBrowser = false;
      profiles.default =
        let
          gmailUrl = "https://mail.google.com/mail/u/0/#inbox";

          containers = {
            Work = {
              color = "blue";
              icon = "briefcase";
              id = 1;
            };
          };

          spaces = {
            Personal = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 1000;
              icon = "🏠";
            };
            Work = {
              id = "64a3730b-6fde-403b-b068-e0aaefe17ced";
              position = 2000;
              icon = "💼";
              container = containers.Work.id;
            };
          };

          pins = {
            gmail = {
              id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
              url = gmailUrl;
              position = 101;
              isEssential = true;
              workspace = spaces.Personal.id;
            };
            "gmail-work" = {
              id = "019dea90-7b70-76d0-8e89-4fd304e7a845";
              url = gmailUrl;
              position = 106;
              isEssential = true;
              workspace = spaces.Work.id;
              container = containers.Work.id;
            };
            calendar = {
              id = "019deaa0-0ca8-76c1-9f94-44fceca9ec44";
              url = "https://calendar.google.com/calendar/u/0/r";
              position = 107;
              isEssential = true;
              workspace = spaces.Work.id;
              container = containers.Work.id;
            };
            slack = {
              id = "019dea97-3ca6-7f4f-9066-2d239d7e6b9d";
              url = "https://app.slack.com";
              position = 108;
              isEssential = true;
              workspace = spaces.Work.id;
              container = containers.Work.id;
            };
            youtube = {
              id = "019dea82-8dd2-76c5-8e13-b77d4080c938";
              url = "https://www.youtube.com/";
              position = 102;
              isEssential = true;

            };
            "x.com" = {
              id = "019dea83-2692-743f-a8a3-45cc6f2a24eb";
              url = "https://x.com/home";
              position = 103;
              isEssential = true;
            };
            github = {
              id = "019dea84-1234-5678-9abc-def012345678";
              url = "https://github.com/sharry";
              position = 104;
              isEssential = true;
            };
            fotmob = {
              id = "019dea8a-6c8f-73d9-971f-eee9276c9532";
              url = "https://www.fotmob.com/";
              position = 105;
              isEssential = true;
            };
          };
        in
        {
          settings = {
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.urlbar.behavior" = "float";
          };
          mods = [
            "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
            "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
          ];
          search = {
            force = true;
            default = "google";
          };
          spacesForce = true;
          inherit spaces;
          containersForce = true;
          inherit containers;
          pinsForce = true; # Delete pins not declared here
          inherit pins;
        };
    }
    (lib.mkIf pkgs.stdenv.isDarwin {
      # Keep Zen configuration in Home Manager, but install the official app
      # bundle so macOS Passwords/passkeys keep the native browser entitlement.
      package = null;
    })
  ];
}
