{ config, lib, pkgs, ... }:

{
  myHomeManager.rclone.enable = true;

  home.packages = with pkgs; [ rclone ];

}
