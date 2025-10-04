{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprsunset
    hyprpaper
    htop
    swaynotificationcenter
    grimblast
    swappy
    libnotify
    cliphist
    wl-clipboard
  ];

  myHomeManager.hyprland.enable = true;
}
