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
  myHomeManager.hyprassets.enable = true;
  myHomeManager.waybar.enable = true;
  myHomeManager.wlogout.enable = true;
  myHomeManager.rofi.enable = true;
  myHomeManager.hypridle.enable = true;
  myHomeManager.hyprlock.enable = true;
  myHomeManager.hyprpaper.enable = true;
  myHomeManager.swaync.enable = true;
}
