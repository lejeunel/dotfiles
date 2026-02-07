{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaynotificationcenter
    swappy
    libnotify
    cliphist
    wl-clipboard
  ];
  myHomeManager.rofi.enable = true;
  myHomeManager.swaync.enable = true;

}
