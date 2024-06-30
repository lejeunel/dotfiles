{ config, inputs, pkgs, font, nix-colors, ...}:{

  imports = [
    ./i3
    ./rofi
  ];

  programs = {

    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        font = "${font}" + " 12";
        adjust-open = "width";
        show-scrollbars = true;
      };
      mappings = {
        "f" = "toggle_fullscreen";
        "b" = "toggle_statusbar";
        "[fullscreen] f" = "toggle_fullscreen";
        "c" = "recolor";
        "p" = "print";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        colors = {
          primary = {
            foreground = "#${config.colorScheme.palette.base07}";
            background = "#${config.colorScheme.palette.base00}";
            dim_foreground = "#${config.colorScheme.palette.base05}";
            bright_foreground = "#${config.colorScheme.palette.base05}";
          };
          cursor = {
            text = "#${config.colorScheme.palette.base00}";
            cursor = "#${config.colorScheme.palette.base06}";
          };
          vi_mode_cursor = {
            text = "#${config.colorScheme.palette.base00}";
            cursor = "#${config.colorScheme.palette.base07}";
          };
          search.matches = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base07}";
          };
          search.focused_match = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base0B}";
          };
          footer_bar = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base07}";
          };
          hints.start = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base0A}";
          };
          hints.end = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base07}";
          };
          selection = {
            foreground = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base06}";
          };
          normal = {
            black = "#${config.colorScheme.palette.base04}";
            red = "#${config.colorScheme.palette.base08}";
            green = "#${config.colorScheme.palette.base0B}";
            yellow = "#${config.colorScheme.palette.base0A}";
            blue = "#${config.colorScheme.palette.base0D}";
            magenta = "#${config.colorScheme.palette.base0E}";
            cyan = "#${config.colorScheme.palette.base07}";
            white = "#${config.colorScheme.palette.base05}";
          };
          bright = {
            black = "#${config.colorScheme.palette.base03}";
            red = "#${config.colorScheme.palette.base08}";
            green = "#${config.colorScheme.palette.base0B}";
            yellow = "#${config.colorScheme.palette.base0A}";
            blue = "#${config.colorScheme.palette.base0D}";
            magenta = "#${config.colorScheme.palette.base0E}";
            cyan = "#${config.colorScheme.palette.base07}";
            white = "#${config.colorScheme.palette.base05}";
          };
          dim = {
            black = "#${config.colorScheme.palette.base03}";
            red = "#${config.colorScheme.palette.base08}";
            green = "#${config.colorScheme.palette.base0B}";
            yellow = "#${config.colorScheme.palette.base0A}";
            blue = "#${config.colorScheme.palette.base0D}";
            magenta = "#${config.colorScheme.palette.base0E}";
            cyan = "#${config.colorScheme.palette.base07}";
            white = "#${config.colorScheme.palette.base05}";
          };
          indexed_colors = [
            {
            index = 16;
            color = "#${config.colorScheme.palette.base09}";
            }
            {
            index = 17;
            color = "#${config.colorScheme.palette.base06}";
            }
          ];
        };
        font = {
          size = 13;
          normal.family = "${font}";
        };
        window.padding = {
          x = 10;
          y = 10;
        };
        env.term = "xterm-256color";

      };
    };

  };


}
