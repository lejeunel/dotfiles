{ config, inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    hyprsunset
    htop
    swaynotificationcenter
    grimblast
    swappy
    libnotify
  ];

  myHomeManager.hyprland.enable = true;
}
