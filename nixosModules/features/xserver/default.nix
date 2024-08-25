{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
      };
    };
    desktopManager.xterm.enable = true;
    windowManager.i3.enable = true;
    xkb.extraLayouts.qwerty-fr = {
      description = "US layout with alt-gr french";
      languages   = [ "eng" ];
      symbolsFile = ./qwerty-fr;
    };
  };

  console.useXkbConfig = true;


  # for touchpad
  services.libinput.enable = true;


}
