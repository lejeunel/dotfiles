{ config, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    settings = [
      {
        layer = "top";
        position = "top";
        mode = "dock";
        height = 32;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        ipc = true;
        fixed-center = true;
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        margin-bottom = 0;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [
          "idle_inhibitor"
          "clock"
        ];
        modules-right = [
          "cpu"
          "memory"
          "backlight"
          "pulseaudio"
          "bluetooth"
          "network"
          "tray"
          "battery"
          "custom/notification"
        ];

        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span color=\"#${config.lib.stylix.colors.base08}\"><sup></sup></span>";
            none = "";
            dnd-notification = "<span color=\"#${config.lib.stylix.colors.base08}\"><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span color=\"#${config.lib.stylix.colors.base08}\"><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span color=\"#${config.lib.stylix.colors.base08}\"><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          active-only = false;
          on-click = "activate";
          persistent-workspaces = {
            "*" = [
              1
              2
              3
              4
              5
              6
              7
              8
              9
              10
            ];
          };
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰥔";
            deactivated = "";
          };
        };

        "clock" = {
          format = "{:%a %d %b %R}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#${config.lib.stylix.colors.base05}'><b>{}</b></span>";
              weekdays = "<span color='#${config.lib.stylix.colors.base0A}'><b>{}</b></span>";
              today = "<span color='#${config.lib.stylix.colors.base08}'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "cpu" = {
          interval = 10;
          format = "󰍛 {usage}%";
          format-alt = "{icon0}{icon1}{icon2}{icon3}";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };

        "memory" = {
          interval = 30;
          format = "󰾆 {percentage}%";
          format-alt = "󰾅 {used}GB";
          max-length = 10;
          tooltip = true;
          tooltip-format = " {used:.1f}GB/{total:.1f}GB";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 2%+";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
        };

        "network" = {
          format-wifi = "󰤨 Wi-Fi";
          format-ethernet = "󱘖 Wired";
          format-linked = "󱘖 {ifname} (No IP)";
          format-disconnected = "󰤮 Off";
          tooltip-format = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          on-click = "${terminal} -t nmtui -e ${pkgs.networkmanager}/bin/nmtui connect";
        };

        "bluetooth" = {
          format = "";
          # format-disabled = ""; # an empty format will hide the module
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = " {device_alias}";
          on-click = "${terminal} -t bluetuith -e ${pkgs.bluetuith}/bin/bluetuith connect";
          on-click-right = "rfkill toggle bluetooth";
        };

        "pulseaudio" = {
          format = "{icon} {volume}";
          format-muted = " ";
          on-click = "${terminal} -t pulsemixer -e ${pkgs.pulsemixer}/bin/pulsemixer";
          tooltip-format = "{icon} {desc} // {volume}%";
          scroll-step = 4;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          tooltip-format = "{format_source} {source_desc} // {source_volume}%";
          scroll-step = 5;
        };

        "tray" = {
          icon-size = 12;
          spacing = 5;
        };

        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/power" = {
          format = "{}";
          on-click = "wlogout -b 4";
          interval = 86400; # once every day
          tooltip = true;
        };
      }
    ];
    style = ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 18px;
        margin: 0px;
        padding: 0px;
      }

      @define-color base   #${config.lib.stylix.colors.base00};
      @define-color mantle #${config.lib.stylix.colors.base01};
      @define-color crust  #${config.lib.stylix.colors.base02};

      @define-color text     #${config.lib.stylix.colors.base05};
      @define-color subtext0 #${config.lib.stylix.colors.base04};
      @define-color subtext1 #${config.lib.stylix.colors.base06};

      @define-color surface0 #${config.lib.stylix.colors.base03};
      @define-color surface1 #${config.lib.stylix.colors.base04};
      @define-color surface2 #${config.lib.stylix.colors.base05};

      @define-color overlay0 #${config.lib.stylix.colors.base07};
      @define-color overlay1 #${config.lib.stylix.colors.base08};
      @define-color overlay2 #${config.lib.stylix.colors.base09};

      @define-color blue      #${config.lib.stylix.colors.base0D};
      @define-color lavender  #${config.lib.stylix.colors.base0E};
      @define-color sapphire  #${config.lib.stylix.colors.base0C};
      @define-color sky       #${config.lib.stylix.colors.base0B};
      @define-color teal      #${config.lib.stylix.colors.base0A};
      @define-color green     #${config.lib.stylix.colors.base0B};
      @define-color yellow    #${config.lib.stylix.colors.base0A};
      @define-color peach     #${config.lib.stylix.colors.base08};
      @define-color maroon    #${config.lib.stylix.colors.base08};
      @define-color red       #${config.lib.stylix.colors.base08};
      @define-color mauve     #${config.lib.stylix.colors.base0E};
      @define-color pink      #${config.lib.stylix.colors.base0F};
      @define-color flamingo  #${config.lib.stylix.colors.base07};
      @define-color rosewater #${config.lib.stylix.colors.base06};

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        background: transparent;
        border-radius: 10px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      tooltip {
        background: @base;
        border-radius: 8px;
        border: 2px solid @red;
      }

      tooltip label {
        color: @text;
        margin-right: 5px;
        margin-left: 5px;
      }

      /* This section can be use if you want to separate waybar modules */
      .modules-left {
      	background: @base;
        border: 2px solid @blue;
      	padding-right: 15px;
      	padding-left: 2px;
      	border-radius: 10px;
      }
      .modules-center {
      	background: @base;
        border: 2px solid @blue;
      	padding-right: 5px;
      	padding-left: 5px;
      	border-radius: 10px;
      }
      .modules-right {
      	background: @base;
        border: 2px solid @blue;
      	padding-right: 15px;
      	padding-left: 15px;
      	border-radius: 10px;
      }

      #backlight,
      #backlight-slider,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #pulseaudio,
      #pulseaudio-slider,
      #taskbar button,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-backlight,
      #custom-cycle_wall,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-menu,
      #custom-power_vertical,
      #custom-power,
      #custom-swaync,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default,
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
      	padding-top: 3px;
      	padding-bottom: 3px;
      	padding-right: 6px;
      	padding-left: 6px;
      }

      #idle_inhibitor {
        color: @green;
      }

      #backlight {
        color: @blue;
      }

      #bluetooth {
        color: @flamingo;
      }

      #battery {
        color: @green;
      }

      @keyframes blink {
        to {
          color: @surface0;
        }
      }

      #battery.critical:not(.charging) {
        background-color: @red;
        color: @text;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        box-shadow: inset 0 -3px transparent;
      }

      #custom-updates {
        color: @blue
      }


      #language {
        color: @blue
      }

      #clock {
        color: @text;
      }

      #custom-icon {
        font-size: 15px;
        color: #cba6f7;
      }

      #cpu {
        color: @yellow;
      }

      #custom-keyboard,
      #memory {
        color: @green;
      }

      #disk {
        color: @sapphire;
      }

      #temperature {
        color: @teal;
      }

      #temperature.critical {
        background-color: @red;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #keyboard-state {
        color: @flamingo;
      }

      #workspaces button {
          box-shadow: none;
          text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          padding-left: 4px;
          padding-right: 4px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
      	border-radius: 10px;
      	color: @overlay0;
      	background-color: @surface0;
       	padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.persistent {
      	color: @surface1;
      	border-radius: 10px;
      }

      #workspaces button.active {
      	color: @red;
        border-radius: 10px;
        padding-left: 8px;
        padding-right: 8px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.urgent {
      	color: @red;
       	border-radius: 0px;
      }

      #taskbar button.active {
          padding-left: 8px;
          padding-right: 8px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button:hover {
          padding-left: 2px;
          padding-right: 2px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #custom-cava_mviz {
      	color: @pink;
      }

      #cava {
      	color: @pink;
      }

      #mpris {
      	color: @pink;
      }

      #custom-menu {
        color: @rosewater;
      }

      #custom-power {
        color: @red;
      }

      #custom-updater {
        color: @red;
      }

      #custom-light_dark {
        color: @blue;
      }

      #custom-weather {
        color: @lavender;
      }

      #custom-lock {
        color: @maroon;
      }

      #pulseaudio {
        color: @lavender;
      }

      #pulseaudio.bluetooth {
        color: @pink;
      }
      #pulseaudio.muted {
        color: @red;
      }

      #window {
        color: @mauve;
      }

      #custom-waybar-mpris {
        color:@lavender;
      }

      #network {
        color: @red;
      }
      #network.disconnected,
      #network.disabled {
        background-color: @surface0;
        color: @text;
      }
      #pulseaudio-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #pulseaudio-slider trough {
      	min-width: 80px;
      	min-height: 5px;
      	border-radius: 5px;
      }

      #pulseaudio-slider highlight {
      	min-height: 10px;
      	border-radius: 5px;
      }

      #backlight-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #backlight-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      }

      #backlight-slider highlight {
      	min-width: 10px;
      	border-radius: 5px;
      }
    '';
  };
}
