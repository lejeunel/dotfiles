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
