{ config, inputs, pkgs, ... }: {
  myHomeManager.i3.enable = true;

  programs.feh = { enable = true; };

  home.packages = with pkgs; [
    i3lock-fancy
    rofi-power-menu
    arandr
    xidlehook
    deadd-notification-center
  ];

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
