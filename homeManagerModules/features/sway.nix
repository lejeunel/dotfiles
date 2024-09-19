{ config, lib, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  term_float = "${terminal} --class floating_shell -e";
  calendar = "${pkgs.calcurse}/bin/calcurse";
  menu = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
  swayexec = "${pkgs.sway}/bin/swaymsg exec --";
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock -f";
  notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
in {
  # TODO add settings for multi monitors
  services.kanshi = { enable = true; };
  services.swaync = { enable = true; };
  xdg.configFile."swaylock/config".text = ''
    ignore-empty-password

    clock
    timestr=%R
    datestr=%a, %e of %B

    screenshots

    effect-blur=20x2
    effect-scale=0.3

    indicator
    indicator-radius=120
    indicator-thickness=10
    indicator-caps-lock

    grace=5

    key-hl-color=${config.lib.stylix.colors.base0B}
    ring-color=${config.lib.stylix.colors.base02}
    line-color=${config.lib.stylix.colors.base01}
    text-wrong-color=${config.lib.stylix.colors.base00}
    ring-wrong-color=${config.lib.stylix.colors.base09}
    line-wrong-color=${config.lib.stylix.colors.base00}
    inside-ver-color=${config.lib.stylix.colors.base0D}
    text-ver-color=${config.lib.stylix.colors.base00}
    ring-ver-color=${config.lib.stylix.colors.base0C}
    line-ver-color=${config.lib.stylix.colors.base0D}
  '';

  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    timeouts = [
      {
        timeout = 60;
        command = "${swaylock}";
      }
      {
        timeout = 90;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [{
      event = "before-sleep";
      command = "${swaylock}";
    }];
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
          xkb_layout = "us";
          xkb_variant = "intl";
        };
      };
      keybindings = lib.mkOptionDefault {

        "XF86AudioMute" = "exec --no-startup-id amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer set Master 4%+";
        "XF86MonBrightnessDown" =
          "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 8%-";
        "XF86MonBrightnessUp" =
          "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl set 8%+";
        "${modifier}+Shift+e" = "mode $mode_shutdown";
        "${modifier}+Shift+s" = "mode $mode_screenshot";
        "${modifier}+e" =
          "exec --no-startup-id ${pkgs.emacs}/bin/emacsclient -nc";
        "${modifier}+n" = "exec --no-startup-id ${notif-center}";
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
        titlebar_border_thickness 2
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
            bindsym l mode "default", exec ${swaylock}

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

        bindsym --release Escape [app_id="floating_shell" con_id=__focused__] kill

        set $grimshot ${pkgs.sway-contrib.grimshot}/bin/grimshot
        set $notify ${pkgs.libnotify}/bin/notify-send
        set $pipe_output $grimshot save output -
        set $pipe_selection $grimshot save area -
        set $notify_paste  [[ $(${pkgs.wl-clipboard-rs}/bin/wl-paste -l) == "image/png" ]] && $notify "Screenshot copied to clipboard"
        set $swappy ${pkgs.swappy}/bin/swappy -f -
        set $swappy_pipe ${pkgs.swappy}/bin/swappy -f - -o -

        set $screenshot_screen $pipe_output | $swappy && $notify_paste

        set $screenshot_selection $pipe_selection | $swappy && $notify_paste

        set $mode_screenshot "<span foreground='#${config.lib.stylix.colors.base04}'>󰄄</span>  \
        <span foreground='#${config.lib.stylix.colors.base06}'><b>Pick</b></span> <span foreground='#${config.lib.stylix.colors.base04}'>(<b>p</b>)</span> \
        <span foreground='#${config.lib.stylix.colors.base06}'><b>Output</b></span> <span foreground='#${config.lib.stylix.colors.base04}'>(<b>o</b>)</span> \
        "
        mode --pango_markup $mode_screenshot {
            # output = currently active output
            bindsym o mode "default", exec $screenshot_screen

            # pick the region to screenshot
            bindsym p mode "default", exec $screenshot_selection

            # Return to default mode.
            bindsym Escape mode "default"
        }

      set $sworkstyle ${pkgs.swayest-workstyle}/bin/sworkstyle
      set $workspace_icons $sworkstyle -d -l info &> /tmp/sworkstyle.log

      exec $workspace_icons

    '';
  };
}
