{ config, lib, pkgs, ... }:
let

  terminal = "${pkgs.alacritty}/bin/alacritty";
  term_float = "${terminal} --class floating_shell -e";
  calendar = "${pkgs.calcurse}/bin/calcurse";
  menu = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
  swayexec = "${pkgs.sway}/bin/swaymsg exec --";

in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-fancy;
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      @keyframes blink-warning {
          70% {
              color: @wm_icon_bg;
          }

          to {
              color: @wm_icon_bg;
              background-color: @warning_color;
          }
      }

      @keyframes blink-critical {
          70% {
              color: @wm_icon_bg;
          }

          to {
              color: @wm_icon_bg;
              background-color: @error_color;
          }
      }

      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
          font-family: "JetBrainsMono Nerd Font", "Roboto Mono", sans-serif;
          font-size: 18px;
      }

      /* The whole bar */
      window#waybar:first-child > box {

          background-color: #${config.lib.stylix.colors.base00};
          color: #f8f8f2;

      }

      /* Each module */
      #custom-pacman,
      #custom-menu,
      #custom-help,
      #custom-scratchpad,
      #custom-github,
      #custom-clipboard,
      #custom-zeit,
      #custom-dnd,
      #bluetooth,
      #battery,
      #clock,
      #cpu,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #idle_inhibitor,
      #backlight,
      #language,
      #custom-adaptive-light,
      #custom-sunset,
      #custom-playerctl,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }

      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #custom-scratchpad,
      #custom-menu,
      #workspaces button.focused,
      #clock {
          color: #${config.lib.stylix.colors.base00};
          background-color: #${config.lib.stylix.colors.base0D};
          border-radius: 8px;
      }

      #workspaces button {
          border-top: 2px solid transparent;
          /* To compensate for the top border and still have vertical centering */
          padding-left: 10px;
          padding-right: 10px;
          color: #${config.lib.stylix.colors.base05};
      }

      #workspaces button.urgent {
          border-color: #${config.lib.stylix.colors.base08};
          color: #${config.lib.stylix.colors.base08};
      }

      button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          background: #${config.lib.stylix.colors.base02};
          border-radius: 8px;
      }

      #custom-zeit.tracking {
          background-color: #${config.lib.stylix.colors.base0B};
      }

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery.warning {
          color: @warning_color;
      }

      #battery.critical {
          color: @error_color;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #clock {
          font-weight: bold;
      }

      #cpu.warning {
          color: @warning_color;
      }

      #cpu.critical {
          color: @error_color;
      }

      #custom-menu {
          padding-left: 8px;
          padding-right: 13px;
          margin: 0 5px;
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #memory.warning {
          color: #${config.lib.stylix.colors.base0B};
      }

      #memory.critical {
          color: #${config.lib.stylix.colors.base08};
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #mode {
          background: #${config.lib.stylix.colors.base00};
      }

      #network.disconnected {
          color: #${config.lib.stylix.colors.base0B};
      }

      #pulseaudio.muted {
          color: #${config.lib.stylix.colors.base0B};
      }

      #temperature.critical {
          color: #${config.lib.stylix.colors.base08};
      }


      #custom-pacman {
          color: #${config.lib.stylix.colors.base0B};
      }

      #bluetooth.disabled {
          color: #${config.lib.stylix.colors.base0B};
      }

      #custom-wf-recorder {
          color: #${config.lib.stylix.colors.base08};
          padding-right: 10px;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "eDP-1" "HDMI-2" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/battery" = {
          interval = 30;
          states = {
            warning = 30;
            critical = 15;
          };
          format-charging = "󰂄 {capacity}%";
          format = "{icon} {capacity}%";
          format-icons = [ "󱃍" "󰁺" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip = true;
        };
        "clock" = {
          interval = 60;
          format = "{:%a %e %b %Y %H:%M}";
          tooltip = true;
          tooltip-format = "<tt>{calendar}</tt>";
          on-click = "${swayexec} ${term_float} ${calendar}";

        };
        "custom/cpu" = {
          interval = 10;
          format = "󰘚";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${swayexec} ${term_float} ${pkgs.htop}/bin/htop";
          tooltip = true;
        };
        "custom/memory" = {
          interval = 10;
          format = "󰍛";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${swayexec} ${term_float} ${pkgs.htop}/bin/htop";
          tooltip = true;
        };
        "custom/network" = {
          interval = 5;
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format = "{icon} {ifname}: {ipaddr}";
          tooltip-format-ethernet = "{icon} {ifname}: {ipaddr}";
          tooltip-format-wifi = "{icon} {ifname} ({essid}): {ipaddr}";
          tooltip-format-disconnected = "{icon} disconnected";
          tooltip-format-disabled = "{icon} disabled";
          on-click =
            "${pkgs.sway}/bin/swaymsg exec -- ${term_float} ${pkgs.networkmanager}/bin/nmtui connect";
        };
        "custom/menu" = {
          format = "󱄅";
          on-click = "${swayexec} \\${menu}";
          tooltip = false;
        };
        "custom/bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          on-click = "swaymsg exec \\$bluetooth";
          on-click-right = "rfkill toggle bluetooth";
          tooltip-format = "{}";
        };
        modules-left = [ "custom/menu" "sway/workspaces" "custom/scratchpad" ];
        modules-center = [ "custom/wf-recorder" "sway/mode" "sway/window" ];
        modules-right = [
          "custom/clipboard"
          "custom/cpu"
          "temperature"
          "memory"
          "battery"

          "custom/network"
          "custom/bluetooth"

          "playerctl"
          "idle_inhibitor"
          "pulseaudio"
          "backlight"

          "tray"
          "clock"
        ];
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      gaps = {
        inner = 10;
        outer = 5;
        smartGaps = true;
      };
      bars = [ ];
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "type:keyboard" = {
          xkb_variant = "qwerty";
          xkb_options = "caps:swapescape";

        };
      };
      keybindings = lib.mkOptionDefault {

        "XF86AudioMute" = "exec --no-startup-id amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 4%+";
        "${modifier}+Shift+e" = "mode $mode_shutdown";
        "${modifier}+e" =
          "exec --no-startup-id ${pkgs.emacs}/bin/emacsclient -nc";
        "${modifier}+Shift+d" =
          "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+d" = "exec --no-startup-id \\${menu}";

        "${modifier}+q" = "kill";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+Ctrl+h" = "workspace prev";
        "${modifier}+Ctrl+l" = "workspace next";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";

        "${modifier}+space" = "focus mod_toggle";
        "${modifier}+Shift+f" = "floating toggle";

        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+c" = "reload";
      };

    };
    extraConfig = ''
      hide_edge_borders smart
      default_border pixel 4
      titlebar_border_thickness 0
      gaps inner 15px
      default_dim_inactive 0.1
      smart_gaps on
      smart_corner_radius on
      corner_radius 4
      blur enable
      shadows enable
      blur_passes 2
      blur_radius 2
      layer_effects "waybar" "blur enable"; shadows enable
      shadow_blur_radius 20

      for_window [app_id="floating_shell"] floating enable, sticky enable, resize set 1000 700
      for_window [app_id="thunderbird" title=".*Reminder"] floating enable

      set $mode_shutdown "\
      <span></span>  \
      <span foreground='#${config.lib.stylix.colors.base06}'> \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>h</b>)</span>hibernate \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>l</b>)</span>lock \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>e</b>)</span>logout \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>r</b>)</span>reboot \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>u</b>)</span>suspend \
      <span foreground='#${config.lib.stylix.colors.base04}'>(<b>s</b>)</span>shutdown \
      <span> -</span>  \
      </span>"

      mode --pango_markup $mode_shutdown {
          # lock
          bindsym l mode "default", exec $locking lock-now

          # logout
          bindsym e exec loginctl terminate-user $USER

          # suspend
          bindsym u mode "default", exec systemctl suspend

          # hibernate
          bindsym h mode "default", exec systemctl hibernate

          # shutdown
          bindsym s exec $purge_cliphist; exec systemctl poweroff

          # reboot
          bindsym r exec $purge_cliphist; exec systemctl reboot

          # Return to default mode.
          bindsym Escape mode "default"
      }

    '';
  };
}
