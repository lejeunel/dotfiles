{
  flake.modules.homeManager.wlogout =
    { pkgs, config, ... }:
    {
      xdg.configFile."wlogout/icons".source = ../../assets/icons;
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "logout";
            action = "${pkgs.niri}/bin/niri msg action quit";
            text = "Exit";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];
        style = ''
          window {
            font-family: monospace;
            font-size: 14pt;
            color: #${config.stylix.base16Scheme.base05}; /* text */
            background-color: #${config.stylix.base16Scheme.base00};
          }

          button {
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            border: none;
            background-color: #${config.stylix.base16Scheme.base01};
            margin: 5px;
            transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
          }

          button:hover {
            background-color: #${config.stylix.base16Scheme.base02};
          }

          button:focus {
            background-color: #${config.stylix.base16Scheme.base0D};
            color: #${config.stylix.base16Scheme.base00};
          }
          #lock {
            background-image: image(url("icons/lock.png"));
          }
          #lock:focus {
            background-image: image(url("icons/lock-hover.png"));
          }

          #logout {
            background-image: image(url("icons/logout.png"));
          }
          #logout:focus {
            background-image: image(url("icons/logout-hover.png"));
          }

          #suspend {
            background-image: image(url("icons/sleep.png"));
          }
          #suspend:focus {
            background-image: image(url("icons/sleep-hover.png"));
          }

          #shutdown {
            background-image: image(url("icons/power.png"));
          }
          #shutdown:focus {
            background-image: image(url("icons/power-hover.png"));
          }

          #reboot {
            background-image: image(url("icons/restart.png"));
          }
          #reboot:focus {
            background-image: image(url("icons/restart-hover.png"));
          }
        '';
      };

    };
}
