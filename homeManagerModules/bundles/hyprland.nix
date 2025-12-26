{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprsunset
    hyprpaper
    swaynotificationcenter
    grimblast
    swappy
    libnotify
    cliphist
    wl-clipboard
  ];

  myHomeManager.hyprland.enable = true;
}
