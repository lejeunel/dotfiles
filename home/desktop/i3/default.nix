{ config, lib, pkgs, font, nix-colors, wallpaper, terminal, ... }:
  let
    term_float = "${terminal} --class floating_shell -e";
    calendar = "${term_float}" + " calcurse";
    bluetooth = "${term_float}" + " bluetuith";
    audio = "${term_float}" + " pulsemixer";
    bluetooth_mac_addr = "/usr/bin/bluetoothctl list | cut -d\  -f2";
    systemctl = "/usr/bin/systemctl";
    locker = "/usr/bin/i3lock-fancy";
    xidlehook = "${pkgs.xidlehook}/bin/xidlehook";
    screenshoter = "/usr/bin/gnome-screenshot -i";
    idlehook = "${xidlehook} --not-when-fullscreen --not-when-audio --timer 60 '${locker}' '' --timer 120 '${systemctl} suspend' ''";
    mode_system = "System (l) lock, (e) logout, (s) suspend";
    # local_layouts_dir = ".local/share/X11/xkb/symbols";

in {


    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = rec {
        window.hideEdgeBorders = "smart";

        window.commands = [
          {
            command = "floating enable, sticky enable, resize set 1000 700, border pixel 1";
            criteria = {
              class = "floating_shell";
            };
          }
          {
            command = "border pixel 5";
            criteria = {
              class = "^.*";
            };
          }
        ];
        bars = [
          {
            fonts = {
              names = ["${font}"];
              size = 12.0;
            };
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs /home/laurent/.config/i3status-rust/config-top.toml";
            colors = rec {
              background = "#${config.colorScheme.palette.base00}";
              focusedBackground = "#${config.colorScheme.palette.base00}";
              statusline = "#${config.colorScheme.palette.base00}";
              focusedStatusline = statusline;
              bindingMode = rec {
                inherit background;
                border = "#${config.colorScheme.palette.base08}";
                text = border;
              };
              focusedWorkspace = {
                background = "#${config.colorScheme.palette.base0D}";
                border = "#${config.colorScheme.palette.base07}";
                text = "#${config.colorScheme.palette.base00}";
              };
              activeWorkspace = {
                inherit background;
                inherit (focusedWorkspace) text border;
              };
              inactiveWorkspace = rec {
                inherit background;
                border = "#${config.colorScheme.palette.base05}";
                text = border;
              };
            };
          }
        ];

        fonts = {
          names = ["${font}"];
          size = 12.0;

        };
        modifier = "Mod1";
        gaps = {
          inner = 10;
          outer = 5;
          smartGaps = true;
        };
        colors = {
          focused = {
            border = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base01}";
            text = "#${config.colorScheme.palette.base07}";
            indicator = "#${config.colorScheme.palette.base00}";
            childBorder = "#${config.colorScheme.palette.base08}";
          };
          unfocused = {
            border = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base00}";
            text = "#${config.colorScheme.palette.base03}";
            indicator = "#${config.colorScheme.palette.base00}";
            childBorder = "#${config.colorScheme.palette.base00}";
          };
          focusedInactive = {
            border = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base00}";
            text = "#${config.colorScheme.palette.base0F}";
            indicator = "#${config.colorScheme.palette.base00}";
            childBorder = "#${config.colorScheme.palette.base00}";
          };
          urgent = {
            border = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base00}";
            text = "#${config.colorScheme.palette.base04}";
            indicator = "#${config.colorScheme.palette.base00}";
            childBorder = "#${config.colorScheme.palette.base00}";
          };
        };

        modes = {
          "${mode_system}" = {
            "l" = "exec --no-startup-id ${locker}, mode \"default\"";
            "e" = "exec i3-msg exit, mode \"default\"";
            "s" = "exec --no-startup-id ${locker} && ${systemctl} suspend, mode \"default\"";
            Escape = ''mode "default"'';
          };

        };
        keybindings = lib.mkOptionDefault {
          "${modifier}+Shift+e" = ''mode "${mode_system}"'';
          "${modifier}+Shift+s" = "exec --no-startup-id ${screenshoter}";

          "XF86AudioMute" = "exec amixer set Master toggle";
          "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
          "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
          "${modifier}+Return" = "exec /usr/bin/alacritty";
          "${modifier}+e" = "exec ${pkgs.emacs}/bin/emacsclient -nc";
          "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";

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
            command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.xorg.setxkbmap}/bin/setxkbmap us_qwerty-fr";
            always = true;
            notification = false;
          }
          {
            command = "${idlehook}";
            always = true;
            notification = false;
          }
        ];
      };
    };

    programs.feh = {
      enable = true;
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {
              block = "focused_window";
              format.full = " $title.str(max_w:100) |";
              format.short = " $title.str(max_w:80) |";
            }
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              interval = 60;
              warning = 20.0;
              alert = 10.0;
            }
            {
              block = "memory";
              format = " $icon $mem_total_used_percents.eng(w:2) ";
              format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "load";
              interval = 1;
              format = " $icon $1m ";
            }
            { block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "${audio}";
                }
              ];

            }
            {
              block = "bluetooth";
              mac = "${bluetooth_mac_addr}";
              click = [
                {
                  button = "left";
                  cmd = "${bluetooth}";
                }
              ];
            }
            {
              block = "time";
              interval = 60;
              click = [
                {
                  button = "left";
                  cmd = "${calendar}";
                }
              ];
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            }
          ];
          settings = {
            theme =  {
              theme = "solarized-dark";
              overrides = {
                idle_bg = "#${config.colorScheme.palette.base00}";
                idle_fg = "#${config.colorScheme.palette.base05}";
              };
            };
          };
          icons = "awesome4";
        };
      };
    };
}
