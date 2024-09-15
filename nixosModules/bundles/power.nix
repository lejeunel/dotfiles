{ config, lib, pkgs, ... }:

{

  services.upower.enable = true;
  services.upower.ignoreLid = true;
}
