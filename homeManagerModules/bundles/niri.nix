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
  myHomeManager.niriassets.enable = true;
  myHomeManager.rofi.enable = true;
  myHomeManager.waybar-niri.enable = true;
  myHomeManager.hyprpaper.enable = true;
  myHomeManager.hyprlock.enable = true;
  myHomeManager.wlogout.enable = true;
  myHomeManager.hypridle.enable = true;
  myHomeManager.swaync.enable = true;

}
