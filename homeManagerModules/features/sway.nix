{ config, lib, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  menu = "${pkgs.rofi-wayland}/bin/rofi -modi drun -show drun";
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock -f";
  notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
  term_float = "${terminal} --class floating_shell -e";

in {
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
        timeout = 300;
        command = "${swaylock} --grace 5";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [{
      event = "before-sleep";
      command = "${swaylock}";
    }];
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "1";
      bars = [ ];
      gaps = {
        inner = 10;
        outer = 5;
        smartGaps = true;
      };
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
            bindsym u mode "default", exec ${pkgs.systemd}/bin/systemctl suspend

            # hibernate
            bindsym h mode "default", exec ${pkgs.systemd}/bin/systemctl hibernate

            # shutdown
            bindsym s exec $purge_cliphist; exec ${pkgs.systemd}/bin/systemctl poweroff

            # reboot
            bindsym r exec $purge_cliphist; exec ${pkgs.systemd}/bin/systemctl reboot

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
