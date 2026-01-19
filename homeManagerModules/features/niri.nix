{ config, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  wlogout = "${pkgs.wlogout}/bin/wlogout";
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  scriptsFPath = "${config.home.homeDirectory}/.config/niri/scripts";
  editor = ''${pkgs.emacs-pgtk}/bin/emacsclient -nc'';
  notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";

in
{
  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd
    spawn-at-startup "waybar"
    output "eDP-1" {
      scale 1.0
    }

    layout {
      gaps 16
      focus-ring {
        width 2
        active-color "#${config.lib.stylix.colors.base0D}"
      }
    }
    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
    }

    binds {
      Mod+Return { spawn "${terminal}"; }
      Mod+Backspace { spawn-sh "pkill -x ${wlogout} || ${wlogout} -b 4"; }
      Mod+E {spawn-sh "${editor}";}
      Mod+Alt+L {spawn "${hyprlock}"; }
      Mod+Space {toggle-overview;}
      Mod+N { spawn-sh "${notif-center}";}

      Mod+Q { close-window; }

      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+M { maximize-window-to-edges; }
      Mod+Ctrl+F { expand-column-to-available-width; }

      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }

      Mod+D { spawn-sh "pkill -x rofi || ${scriptsFPath}/rofi.sh drun"; }

      Mod+H { focus-column-left; }
      Mod+L { focus-column-right; }
      Mod+J { focus-workspace-down; }
      Mod+K { focus-workspace-up; }

      Mod+Shift+H { move-column-left; }
      Mod+Shift+L { move-column-right; }
      Mod+Shift+J { move-window-down; }
      Mod+Shift+K { move-window-up; }
    }
  '';
}
