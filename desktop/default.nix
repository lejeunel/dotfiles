{ config, inputs, pkgs, font, nix-colors, ...}:{

  imports = [
    ./i3
    ./rofi
    ./alacritty
    ./zathura
    ./imv
  ];

  xdg.desktopEntries = {
    imv-x11 = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "/usr/bin/imv-x11 -n %f .";
    };
    emacsclient = {
      name = "Emacs Client";
      genericName = "Text Editor";
      exec = "${pkgs.emacs}/bin/emacsclient -nc %f";
      icon = "emacs";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["imv-x11.desktop"];
      "image/jpeg" = ["imv-x11.desktop"];
      "image/gif" = ["imv-x11.desktop"];

      "text/plain" = ["emacsclient.desktop"];
      "text/x-script.python" = ["emacsclient.desktop"];
      "text/x-tex" = ["emacsclient.desktop"];

      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };
  };
}
