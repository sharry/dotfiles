{
  services.aerospace = {
    enable = true;
    settings = {

      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      enable-normalization-flatten-containers = true;
      automatically-unhide-macos-hidden-apps = false;
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      enable-normalization-opposite-orientation-for-nested-containers = true;

      gaps = {

        outer.top         = 5;
        outer.left        = 5;
        outer.right       = 5;
        outer.bottom      = 5;

        inner.vertical    = 5;
        inner.horizontal  = 5;

      };

      mode.main.binding = {
        
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-k = "move up";
        alt-shift-j = "move down";
        alt-shift-h = "move left";
        alt-shift-l = "move right";

        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-a = "workspace A";
        alt-b = "workspace B";
        alt-c = "workspace C";
        alt-d = "workspace D";
        alt-e = "workspace E";
        alt-f = "workspace F";
        alt-g = "workspace G";
        alt-i = "workspace I";
        alt-m = "workspace M";
        alt-n = "workspace N";
        alt-o = "workspace O";
        alt-p = "workspace P";
        alt-q = "workspace Q";
        alt-r = "workspace R";
        alt-s = "workspace S";
        alt-t = "workspace T";
        alt-u = "workspace U";
        alt-v = "workspace V";
        alt-w = "workspace W";
        alt-x = "workspace X";
        alt-y = "workspace Y";
        alt-z = "workspace Z";

        alt-shift-1 = ["move-node-to-workspace 1" "workspace 1"];
        alt-shift-2 = ["move-node-to-workspace 2" "workspace 2"];
        alt-shift-3 = ["move-node-to-workspace 3" "workspace 3"];
        alt-shift-4 = ["move-node-to-workspace 4" "workspace 4"];
        alt-shift-5 = ["move-node-to-workspace 5" "workspace 5"];
        alt-shift-6 = ["move-node-to-workspace 6" "workspace 6"];
        alt-shift-7 = ["move-node-to-workspace 7" "workspace 7"];
        alt-shift-8 = ["move-node-to-workspace 8" "workspace 8"];
        alt-shift-9 = ["move-node-to-workspace 9" "workspace 9"];
        alt-shift-a = ["move-node-to-workspace A" "workspace A"];
        alt-shift-b = ["move-node-to-workspace B" "workspace B"];
        alt-shift-c = ["move-node-to-workspace C" "workspace C"];
        alt-shift-d = ["move-node-to-workspace D" "workspace D"];
        alt-shift-e = ["move-node-to-workspace E" "workspace E"];
        alt-shift-f = ["move-node-to-workspace F" "workspace F"];
        alt-shift-g = ["move-node-to-workspace G" "workspace G"];
        alt-shift-i = ["move-node-to-workspace I" "workspace I"];
        alt-shift-m = ["move-node-to-workspace M" "workspace M"];
        alt-shift-n = ["move-node-to-workspace N" "workspace N"];
        alt-shift-o = ["move-node-to-workspace O" "workspace O"];
        alt-shift-p = ["move-node-to-workspace P" "workspace P"];
        alt-shift-q = ["move-node-to-workspace Q" "workspace Q"];
        alt-shift-r = ["move-node-to-workspace R" "workspace R"];
        alt-shift-s = ["move-node-to-workspace S" "workspace S"];
        alt-shift-t = ["move-node-to-workspace T" "workspace T"];
        alt-shift-u = ["move-node-to-workspace U" "workspace U"];
        alt-shift-v = ["move-node-to-workspace V" "workspace V"];
        alt-shift-w = ["move-node-to-workspace W" "workspace W"];
        alt-shift-x = ["move-node-to-workspace X" "workspace X"];
        alt-shift-y = ["move-node-to-workspace Y" "workspace Y"];
        alt-shift-z = ["move-node-to-workspace Z" "workspace Z"];

        alt-shift-semicolon = "mode service";

      };

      mode.service.binding = {

        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];

        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];

      };

    };
  };
}