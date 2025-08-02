{ config, inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprsunset
    hyprpaper
    htop
    swaynotificationcenter
    grimblast
    swappy
    libnotify
  ];

  myHomeManager.hyprland.enable = true;
}
