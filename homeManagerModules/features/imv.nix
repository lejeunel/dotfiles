{
  pkgs,
  ...
}:

{
  programs.imv = {
    enable = true;
    settings = {
      options.suppress_default_binds = false;
      binds = {
        "<Escape>" = "quit";
        "q" = "quit";

        "<Left>" = "prev";
        "<Right>" = "next";
        "<Ctrl+k>" = "prev";
        "<Ctrl+j>" = "next";

        "f" = "fullscreen";

        "j" = "pan 0 -50";
        "k" = "pan 0 50";
        "h" = "pan 50 0";
        "l" = "pan -50 0";
      };
    };
  };

  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "${pkgs.imv}/bin/imv -n %f .";
    };
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];
    };
  };

}
