{ config, inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    swayfx
    swayidle
    sway-contrib.grimshot
    swappy
    libnotify
    wl-clipboard-rs
    swayest-workstyle
    swaylock-effects
    swaynotificationcenter
  ];

  myHomeManager.sway.enable = true;
}
