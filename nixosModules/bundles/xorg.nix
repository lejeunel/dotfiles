{ config, lib, pkgs, ... }:

{
  myNixOS.xserver.enable = true;
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

}
