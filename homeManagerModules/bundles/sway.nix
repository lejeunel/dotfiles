{ config, inputs, pkgs, ... }: {
  home.packages = with pkgs; [ swayfx swaylock-fancy ];

  myHomeManager.sway.enable = true;
}
