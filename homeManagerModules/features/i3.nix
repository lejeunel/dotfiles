{ config, lib, pkgs, ... }:
let
  timeout_lock = "120";
  timeout_suspend = "120";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  term_float = "${terminal} --class floating_shell -e";
  nmui = "${term_float}" + " ${pkgs.networkmanager}/bin/nmtui";
  top = "${term_float}" + " ${pkgs.htop}/bin/htop";
  calendar = "${term_float}" + " ${pkgs.calcurse}/bin/calcurse";
  bluetooth = "${term_float}" + " ${pkgs.bluetuith}/bin/bluetuith";
  audio = "${term_float}" + " ${pkgs.pulsemixer}/bin/pulsemixer";
  bluetooth_mac_addr =
    "${pkgs.bluez-experimental}/bin/bluetoothctl list | cut -d  -f2";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  xidlehook = "${pkgs.xidlehook}/bin/xidlehook";
  screenshoter = "${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot -i";
  idlehook =
    "${xidlehook} --not-when-fullscreen --not-when-audio --timer '${timeout_lock}' '${locker}' '' --timer '${timeout_suspend}' '${systemctl} suspend' ''";
  mode_system = "System (l)ock, l(o)gout, (s)uspend (h)ibernate (p)oweroff";

in {

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = {
      "bar/top" = {
        font-0 = "JetBrainsMono Nerd Font";
        font-1 = "JetBrainsMono Nerd Font:weight=bold";
        background = "#${config.lib.stylix.colors.base00}";
        width = "100%";
        height = "30pt";
        radius = 0;
        padding-left = 0;
        padding-right = 0;
        module-margin = 0;
        border-left-size = 0;
        border-right-size = 0;
        border-top-size = 0;
        line-size = 4;
        modules-left = "i3";
        modules-center = "title";
        modules-right =
          "tray bluetooth network fs-root memory cpu battery alsa date";
      };
      "module/title" = { type = "internal/xwindow"; };
      "module/bluetooth" = {
        type = "custom/text";
        label = " 󰂯 ";
        format-background = "#${config.lib.stylix.colors.base0B}";
        click-left = "${bluetooth}";
      };
      "module/network" = {
        type = "custom/text";
        label = "󰖩 ";
        format-background = "#${config.lib.stylix.colors.base0B}";
        click-left = "${nmui}";
      };
      "fs-base" = {
        type = "internal/fs";
        label-mounted-background = "#${config.lib.stylix.colors.base0C}";

      };
      "module/fs-root" = {
        "inherit" = "fs-base";
        mount-0 = "/";
        label-mounted = "  %percentage_used%% ";
      };
      # "module/fs-home" = {
      #   "inherit" = "fs-base";
      #   mount-0 = "/home";
      #   label-mounted = " %percentage_used%% ";
      # };
      "module/cpu" = {
        type = "internal/cpu";
        label = "󱚥 %percentage%% ";
        format-background = "#${config.lib.stylix.colors.base0D}";
      };
      "module/memory" = {
        type = "internal/memory";
        format-prefix = "  ";
        format-background = "#${config.lib.stylix.colors.base0D}";
        label = "%percentage_used%% ";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";
        full-at = "98";

        format-charging = "<animation-charging> <label-charging>";

        format-discharging = "<ramp-capacity> <label-discharging>";

        format-full-prefix = " ";
        format-full-prefix-background = "${config.lib.stylix.colors.base0D}";

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-background = "${config.lib.stylix.colors.base0D}";

        animation-charging-0 = "";
        animation-charging-1 = "";
        # animation-charging-2 = "";
        animation-charging-background = "${config.lib.stylix.colors.base0D}";
        animation-charging-framerate = "750";
      };
      "module/alsa" = {
        type = "internal/alsa";
        format-volume-prefix = " ";
        format-volume-background = "${config.lib.stylix.colors.base0E}";
        format-volume = "<label-volume>";

        label-volume = "%percentage%%";
        label-volume-padding-right = 1;
        label-volume-padding-left = 1;

        label-muted = " 󰝟     ";
        label-muted-background = "${config.lib.stylix.colors.base0E}";
      };
      "module/date" = {
        type = "internal/date";
        date = "%a %d/%m";
        time = "%H:%M";
        label = "%{A1:${calendar}:} %date% %time%%{A} ";
        format-background = "#${config.lib.stylix.colors.base0F}";
      };
      "module/tray" = {
        type = "internal/tray";
        tray-padding = "20px";
        tray-foreground = "${config.lib.stylix.colors.base09}";
      };
      "module/i3" = {
        type = "internal/i3";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
        pin-workspaces = true;

        label-focused = "%{T2}%index%%{T-}";
        label-focused-foreground = "${config.lib.stylix.colors.base09}";
        label-focused-underline = "${config.lib.stylix.colors.base09}";
        label-focused-padding = 1;

        label-unfocused = "%index%";
        label-unfocused-foreground = "${config.lib.stylix.colors.base06}";
        label-unfocused-padding = 1;

        label-urgent = "%index%";
        label-urgent-background = "${config.lib.stylix.colors.base08}";
        label-urgent-padding = 1;

        label-empty = "%index%";
        label-empty-foreground = "${config.lib.stylix.colors.base0F}";
        label-empty-padding = 1;

      };
    };
    script = ''
      PATH=$PATH:${pkgs.i3}/bin
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
          MONITOR=$m polybar --reload top &
      done'';
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    extraConfig = ''
      font pango:JetBrainsMono Nerd Font 10
    '';
    config = rec {
      bars = [ ];
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
          "h" = ''
            exec --no-startup-id ${locker} && ${systemctl} hibernate, mode "default"'';
          "p" = ''
            exec --no-startup-id ${locker} && ${systemctl} poweroff, mode "default"'';
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
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ${config.stylix.image}";
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

}
