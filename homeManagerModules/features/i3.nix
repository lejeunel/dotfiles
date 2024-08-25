{ config, lib, pkgs, ... }:
let
  font = "JetBrainsMono Nerd Font";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  term_float = "${terminal} --class floating_shell -e";
  nmui = "${term_float}" + " ${pkgs.networkmanager}/bin/nmtui";
  calendar = "${term_float}" + " calcurse";
  bluetooth = "${term_float}" + " bluetuith";
  audio = "${term_float}" + " pulsemixer";
  bluetooth_mac_addr =
    "${pkgs.bluez-experimental}/bin/bluetoothctl list | cut -d  -f2";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  xidlehook = "${pkgs.xidlehook}/bin/xidlehook";
  screenshoter = "${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot -i";
  idlehook =
    "${xidlehook} --not-when-fullscreen --not-when-audio --timer 60 '${locker}' '' --timer 120 '${systemctl} suspend' ''";
  mode_system = "System (l)ock, l(o)gout, (s)uspend";

in {

  home.packages = with pkgs; [ i3status-rust i3lock-fancy rofi-power-menu ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = rec {
      window.hideEdgeBorders = "smart";

      window.commands = [
        {
          command =
            "floating enable, sticky enable, resize set 1000 700, border pixel 1";
          criteria = { class = "floating_shell"; };
        }
        {
          command = "border pixel 5";
          criteria = { class = "^.*"; };
        }
      ];
      bars = [{
        fonts = {
          names = [ "${font}" ];
          size = 12.0;
        };
        position = "top";
        statusCommand =
          "${pkgs.i3status-rust}/bin/i3status-rs /home/laurent/.config/i3status-rust/config-top.toml";
      }];

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 12.0;

      };
      modifier = "Mod1";
      gaps = {
        inner = 10;
        outer = 5;
        smartGaps = true;
      };

      modes = {
        "${mode_system}" = {
          "l" = ''exec --no-startup-id ${locker}, mode "default"'';
          "o" = ''exec --no-startup-id i3-msg exit, mode "default"'';
          "s" = ''
            exec --no-startup-id ${locker} && ${systemctl} suspend, mode "default"'';
          Escape = ''mode "default"'';
        };

      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+e" = ''mode "${mode_system}"'';
        "${modifier}+Shift+s" = "exec --no-startup-id ${screenshoter}";

        "XF86AudioMute" = "exec --no-startup-id amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 4%+";
        "${modifier}+Return" = "exec --no-startup-id ${terminal}";
        "${modifier}+e" =
          "exec --no-startup-id ${pkgs.emacs}/bin/emacsclient -nc";
        "${modifier}+Shift+d" =
          "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+d" =
          "exec --no-startup-id ${pkgs.rofi}/bin/rofi -modi drun -show drun";

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

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.xorg.setxkbmap}/bin/setxkbmap qwerty-fr";
          always = true;
          notification = false;
        }
        {
          command = ''
            ${pkgs.xorg.xinput}/bin/xinput --set-prop $(${pkgs.xorg.xinput}/bin/xinput list --id-only 'Microsoft Microsoft Pro Intellimouse Mouse') 'libinput Accel Profile Enabled' 0, 1
          '';
          always = true;
          notification = false;
        }
        {
          command = ''
            ${pkgs.xorg.xinput}/bin/xinput --set-prop $(${pkgs.xorg.xinput}/bin/xinput list --id-only 'Microsoft Microsoft Pro Intellimouse Mouse') 'libinput Accel Speed' -0.55
          '';
          always = true;
          notification = false;
        }
        {
          command = "${idlehook}";
          always = true;
          notification = false;
        }
        {
          command =
            "${pkgs.deadd-notification-center}/bin/deadd-notification-center";
          always = false;
          notification = false;
        }

      ];
    };
  };

  programs.feh = { enable = true; };

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
          {
            block = "sound";
            click = [{
              button = "left";
              cmd = "${audio}";
            }];

          }
          {
            block = "bluetooth";
            mac = "${bluetooth_mac_addr}";
            click = [{
              button = "left";
              cmd = "${bluetooth}";
            }];
          }
          {
            block = "net";
            click = [{
              button = "left";
              cmd = "${nmui}";
            }];
          }
          {
            block = "time";
            interval = 60;
            click = [{
              button = "left";
              cmd = "${calendar}";
            }];
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
        icons = "awesome4";
      };
    };
  };
}
