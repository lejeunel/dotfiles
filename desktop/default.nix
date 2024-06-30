{ config, inputs, pkgs, font, nix-colors, ...}:{

  imports = [
    ./i3
    ./rofi
    ./alacritty
    ./zathura
    ./imv
  ];
}
