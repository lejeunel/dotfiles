{ config, lib, pkgs, ... }:

{

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez-experimental
  ];

}
