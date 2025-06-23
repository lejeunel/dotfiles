{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ bluez-experimental ];

}
