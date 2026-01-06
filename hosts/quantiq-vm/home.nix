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
    bundles.stylix.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
    bundles.k8s.enable = true;
    bundles.dev.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      xorg.setxkbmap
      networkmanager
      ubuntu-classic
      roboto-serif
    ];
  };

}
