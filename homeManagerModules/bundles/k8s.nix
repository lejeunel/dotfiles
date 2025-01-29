{ pkgs, ... }:

{
  myHomeManager.rclone.enable = true;

  home.packages = with pkgs; [ fluxcd ];

}
