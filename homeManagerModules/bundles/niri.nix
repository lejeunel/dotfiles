{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaynotificationcenter
    swappy
    libnotify
    cliphist
    wl-clipboard
  ];
  myHomeManager.niri.enable = true;
  myHomeManager.rofi.enable = true;
  myHomeManager.waybar-niri.enable = true;
  myHomeManager.wlogout-niri.enable = true;
  myHomeManager.hypridle-niri.enable = true;
  myHomeManager.hyprpaper.enable = true;
  myHomeManager.hyprlock.enable = true;
  myHomeManager.swaync.enable = true;

}
