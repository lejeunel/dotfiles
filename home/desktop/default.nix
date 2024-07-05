{ config, inputs, pkgs, font, nix-colors, dotfilesPath, ...}:{

  imports = [
    ./i3
    ./rofi
    ./alacritty
    ./zathura
    ./imv
  ];


  home.packages = with pkgs; [
      thunderbird
      xidlehook
      dconf
      gnome.nautilus
      gnome.gnome-screenshot
  ];

  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "${pkgs.imv}/bin/imv -n %f .";
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
      "image/png" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];

      "text/plain" = ["emacsclient.desktop"];
      "text/x-script.python" = ["emacsclient.desktop"];
      "text/x-tex" = ["emacsclient.desktop"];

      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };
  };

  programs.firefox.enable = true;

  # themes, icons, wallpapers, ...
  home.file.".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-light";
  home.file."Pictures/lonely-fish.png".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/wallpapers/lonely-fish.png";

  gtk = {
    enable = true;
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
    cursorTheme = {
      name = "Phinger Cursors (light)";
      package = pkgs.phinger-cursors;
    };
    theme = {
      name = "Matcha-dark-azul";
      package = pkgs.matcha-gtk-theme;
    };
    font = {
      name = "Ubuntu";
      size = 12;
      package = pkgs.ubuntu_font_family;
    };

  };

}
