{ config, inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    swayfx
    swayidle
    sway-contrib.grimshot
    swappy
    libnotify
    wl-clipboard-rs
    swayest-workstyle
  ];

  myHomeManager.sway.enable = true;
}
