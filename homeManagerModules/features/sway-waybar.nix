{ config, lib, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  menu = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
  notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
  swayexec = "${pkgs.sway}/bin/swaymsg exec --";
  calendar = "${pkgs.calcurse}/bin/calcurse";
  term_float = "${terminal} --class floating_shell -e";
in {
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
      #custom-menu,
      #custom-help,
      #custom-scratchpad,
      #custom-github,
      #custom-clipboard,
      #custom-notification,
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
          padding-left: 10px;
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
        output = [ "eDP-1" "HDMI-A-2" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "battery" = {
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
        "cpu" = {
          interval = 10;
          format = "󰘚";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${swayexec} ${term_float} ${pkgs.htop}/bin/htop";
          tooltip = true;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 1;
          on-click =
            "${swayexec} ${term_float} ${pkgs.pulsemixer}/bin/pulsemixer";
        };
        "memory" = {
          interval = 10;
          format = "󰍛 {}%";
          states = {
            warning = 70;
            critical = 90;
          };
          on-click = "${swayexec} ${term_float} ${pkgs.htop}/bin/htop";
          tooltip = true;
        };
        "network" = {
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
            "${swayexec} ${term_float} ${pkgs.networkmanager}/bin/nmtui connect";
        };
        "custom/menu" = {
          format = "󱄅";
          on-click = "${swayexec} \\${menu}";
          tooltip = false;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
          tooltip = true;
          tooltip-format-activated = "idle inhibitor enabled";
          tooltip-format-deactivated = "idle inhibitor disabled";
        };
        "custom/notification" = {
          format = "󰎟";
          on-click = "${notif-center}";
        };
        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";

          on-click =
            "${swayexec} ${term_float} ${pkgs.bluetuith}/bin/bluetuith connect";
          on-click-right = "rfkill toggle bluetooth";
          tooltip-format = "{}";
        };
        modules-left = [ "custom/menu" "sway/workspaces" "custom/scratchpad" ];
        modules-center = [ "sway/mode" "sway/window" ];
        modules-right = [
          "cpu"
          "temperature"
          "memory"
          "battery"
          "pulseaudio"
          "idle_inhibitor"

          "network"
          "bluetooth"
          "custom/notification"

          "tray"
          "clock"
        ];
      };
    };
  };
}
