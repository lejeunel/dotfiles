{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.rclone.enable = true;
    bundles.desktop.enable = true;
    bundles.i3.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
    bundles.general.enable = true;
    bundles.dev.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      xorg.setxkbmap
      networkmanager
      ubuntu_font_family
      roboto-serif
    ];
  };

}
