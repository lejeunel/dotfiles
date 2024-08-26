{ config, inputs, pkgs, ... }: {

  myHomeManager.i3.enable = true;
  myHomeManager.rofi.enable = true;
  myHomeManager.alacritty.enable = true;
  myHomeManager.zathura.enable = true;
  myHomeManager.imv.enable = true;
  myHomeManager.office.enable = true;
  myHomeManager.stylix.enable = true;
  myHomeManager.gtk.enable = true;

  home.packages = with pkgs; [
    thunderbird
    xidlehook
    dconf
    gnome.nautilus
    gnome.gnome-screenshot
    gnome.gnome-calculator
    deadd-notification-center
    telegram-desktop
    evince
    inkscape
    vlc
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
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];

      "text/plain" = [ "emacsclient.desktop" ];
      "text/x-script.python" = [ "emacsclient.desktop" ];
      "text/x-tex" = [ "emacsclient.desktop" ];

      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };

  programs.firefox.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
    inactiveOpacity = 0.95;
    vSync = true;
    activeOpacity = 1;
    settings = { blur = { strength = 5; }; };
  };

}
