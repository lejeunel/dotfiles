{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.xidlehook
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xterm.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # for touchpad
  services.libinput.enable = true;

}
