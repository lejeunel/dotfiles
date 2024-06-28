{ config, lib, pkgs, font, ... }:

{

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = rec {
      fonts = {
        names = ["${font}"];
        size = 12.0;

      };
      modifier = "Mod1";
      gaps = {
        inner = 10;
        outer = 5;
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec /usr/bin/alacritty";
        "${modifier}+e" = "exec /usr/bin/emacsclient -nc";
        "${modifier}+Shift+d" = "exec /usr/bin/rofi -show window";
        "${modifier}+d" = "exec /usr/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+e" = "exec systemctl suspend";

        "${modifier}+q" = "kill";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";

        "${modifier}+space" = "focus mod_toggle";
        "${modifier}+Shift+space" = "floating toggle";

        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+c" = "reload";
      };

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "/usr/bin/feh --bg-scale ~/Pictures/catppuccin-wallpapers/misc/lonely-fish.png";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
