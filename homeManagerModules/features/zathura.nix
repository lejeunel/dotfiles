{ config, lib, pkgs, font, nix-colors, ... }: {

  programs.zathura = {
    enable = true;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      font = "${font}" + " 12";
      adjust-open = "width";
      show-scrollbars = true;

      default-fg = "#${config.colorScheme.palette.base05}";
      default-bg = "#${config.colorScheme.palette.base00}";
      completion-bg = "#${config.colorScheme.palette.base02}";
      completion-fg = "#${config.colorScheme.palette.base00}";

      completion-highlight-bg = "#${config.colorScheme.palette.base03}";
      completion-highlight-fg = "#${config.colorScheme.palette.base00}";

      completion-group-bg = "#${config.colorScheme.palette.base02}";
      completion-group-fg = "#${config.colorScheme.palette.base00}";

      statusbar-fg = "#${config.colorScheme.palette.base05}";
      statusbar-bg = "#${config.colorScheme.palette.base02}";

      notification-bg = "#${config.colorScheme.palette.base02}";
      notification-fg = "#${config.colorScheme.palette.base05}";
      notification-error-bg = "#${config.colorScheme.palette.base02}";
      notification-error-fg = "#${config.colorScheme.palette.base08}";
      notification-warning-bg = "#${config.colorScheme.palette.base02}";
      notification-warning-fg = "#${config.colorScheme.palette.base0A}";

      inputbar-fg = "#${config.colorScheme.palette.base05}";
      inputbar-bg = "#${config.colorScheme.palette.base02}";

      recolor-lightcolor = "#${config.colorScheme.palette.base00}";
      recolor-darkcolor = "#${config.colorScheme.palette.base05}";

      index-fg = "#${config.colorScheme.palette.base05}";
      index-bg = "#${config.colorScheme.palette.base00}";
      index-active-fg = "#${config.colorScheme.palette.base05}";
      index-active-bg = "#${config.colorScheme.palette.base02}";

      render-loading-bg = "#${config.colorScheme.palette.base00}";
      render-loading-fg = "#${config.colorScheme.palette.base05}";

      highlight-color = "#${config.colorScheme.palette.base01}";
      highlight-fg = "#${config.colorScheme.palette.base0E}";
      highlight-active-color = "#${config.colorScheme.palette.base0E}";
    };
    mappings = {
      "f" = "toggle_fullscreen";
      "b" = "toggle_statusbar";
      "[fullscreen] f" = "toggle_fullscreen";
      "c" = "recolor";
      "p" = "print";
      "r" = "reload";
      "R" = "rotate";

      "K" = "zoom in";
      "J" = "zoom out";
    };
  };

}
