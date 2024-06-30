{ config, inputs, pkgs, font, nix-colors, ...}:{

  imports = [
    ./i3
    ./rofi
    ./alacritty
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

  };


}
