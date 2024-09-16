{ pkgs, lib, ... }: {
  myNixOS.wayland.enable = true;
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

  environment.systemPackages = with pkgs; [ nwg-displays ];

}
