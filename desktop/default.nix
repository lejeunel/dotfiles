{ inputs, pkgs, font, ...}:{

  programs = {

    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        font = "${font}";
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
        import = [ pkgs.alacritty-theme.catppuccin_macchiato ];
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
