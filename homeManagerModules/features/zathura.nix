{
  config,
  ...
}:
{

  programs.zathura = {
    enable = true;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      font = "${config.stylix.fonts.monospace.name} + 12";
      adjust-open = "width";
      show-scrollbars = true;
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
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };

}
