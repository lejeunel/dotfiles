{ config, lib, pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users = {
    laurent = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
      shell = pkgs.zsh;
    };
  };


}
