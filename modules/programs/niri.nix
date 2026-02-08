{ ... }:
{
  flake.modules.nixos.niri =
    { inputs, pkgs, ... }:
    {
      imports = [
        inputs.niri-flake.nixosModules.niri
      ];

      programs.niri.enable = true;
      nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
      programs.niri.package = pkgs.niri-unstable;
      environment.variables.NIXOS_OZONE_WL = "1";

      # Required for Wayland compositors
      services.dbus.enable = true;
      services.gnome.gnome-keyring.enable = true;

      services.seatd.enable = true;

      # Optional but recommended
      security.polkit.enable = true;

      # Fonts (niri needs at least one font)
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        noto-fonts
      ];

      environment.systemPackages = with pkgs; [
        wdisplays
      ];

    };
  flake.modules.homeManager.niri =
    {
      pkgs,
      inputs,
      config,
      ...
    }:
    let
      terminal = "${pkgs.alacritty}/bin/alacritty";
      wlogout = "${pkgs.wlogout}/bin/wlogout";
      hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
      scriptsFPath = "${config.home.homeDirectory}/.config/niri/scripts";
      editor = ''${pkgs.emacs-pgtk}/bin/emacsclient -nc'';
      notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
      clipboard = "${pkgs.wl-clipboard-rs}/bin/wl-paste";

    in
    {
      home.packages = with pkgs; [
        swaynotificationcenter
        swappy
        libnotify
        cliphist
        wl-clipboard
      ];
      imports = [
        inputs.niri-flake.homeModules.niri
      ];

      xdg.configFile."niri/scripts" = {
        source = ../../assets/scripts;
        recursive = true;
      };
      xdg.configFile."niri/icons" = {
        source = ../../assets/icons;
        recursive = true;
      };

      programs.niri = {
        enable = true;
        settings = {
          prefer-no-csd = true;

          spawn-at-startup = [
            { argv = [ "${pkgs.waybar}/bin/waybar" ]; }
            {
              argv = [
                "${clipboard}"
                "--watch"
                "cliphist"
                "store"
              ];
            }
            {
              argv = [
                "${clipboard}"
                "--type"
                "text"
                "--watch"
                "cliphist"
                "store"
              ];
            }
            {
              argv = [
                "${clipboard}"
                "--type"
                "image"
                "--watch"
                "cliphist"
                "store"
              ];
            }
          ];
          hotkey-overlay.skip-at-startup = true;
          outputs = {
            "eDP-1" = {
              scale = 1.0;
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.049;
              };
              position = {
                x = 330;
                y = 1440;
              };
            };
            "HDMI-A-2" = {
              scale = 1.0;
              mode = {
                width = 2560;
                height = 1440;
                refresh = 59.951;
              };
              position = {
                x = 0;
                y = 0;
              };
            };

          };

          input = {
            focus-follows-mouse.enable = false;
            keyboard = {
              xkb = {
                layout = "us";
                variant = "intl";
              };
            };
            touchpad = {
              tap = true;
              natural-scroll = true;
            };
          };

          layout = {
            gaps = 12;
            focus-ring = {
              width = 2;
              active.color = "#${config.lib.stylix.colors.base0D}";
            };
          };
          window-rules = [
            {
              draw-border-with-background = false;
              geometry-corner-radius =
                let
                  r = 12.0;
                in
                {
                  top-left = r;
                  top-right = r;
                  bottom-left = r;
                  bottom-right = r;
                };
              clip-to-geometry = true;
            }
          ];

          binds = {
            "Mod+Return".action.spawn = "${terminal}";
            "Mod+Backspace".action.spawn-sh = "pkill -x ${wlogout} || ${wlogout} -b 4";
            "Mod+E".action.spawn-sh = "${editor}";
            "Mod+Alt+L".action.spawn = [ "${hyprlock}" ];
            "Mod+Space".action.toggle-overview = [ ];
            "Mod+S".action.screenshot = [ ];
            "Mod+C".action.spawn-sh = "${notif-center}";
            "Mod+Q".action.close-window = [ ];
            "Mod+F".action.maximize-column = [ ];
            "Mod+Shift+F".action.fullscreen-window = [ ];
            "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
            "Mod+Minus".action.set-column-width = "-10%";
            "Mod+Equal".action.set-column-width = "+10%";

            "Mod+D".action.spawn-sh = "pkill -x rofi || ${scriptsFPath}/rofi.sh drun";

            "Mod+H".action.focus-column-left = [ ];
            "Mod+L".action.focus-column-right = [ ];
            "Mod+J".action.focus-workspace-down = [ ];
            "Mod+K".action.focus-workspace-up = [ ];
            "Mod+P".action.focus-monitor-up = [ ];
            "Mod+N".action.focus-monitor-down = [ ];

            "Mod+Shift+H".action.move-column-left = [ ];
            "Mod+Shift+L".action.move-column-right = [ ];
            "Mod+Shift+J".action.move-window-to-workspace-down = [ ];
            "Mod+Shift+K".action.move-window-to-workspace-up = [ ];
          };
        };
      };

    };

}
