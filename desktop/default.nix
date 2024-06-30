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
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["imv-x11.desktop"];
      "image/jpeg" = ["imv-x11.desktop"];
    };
  };
}
