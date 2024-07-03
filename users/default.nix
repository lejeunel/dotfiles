{ config, lib, pkgs, ... }:

{
  users.users = {
    laurent = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
      shell = pkgs.zsh;
    };
  };


}
