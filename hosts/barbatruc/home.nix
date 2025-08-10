{ outputs, pkgs, ... }:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.hyprland.enable = true;
    bundles.desktop.enable = true;
    bundles.shell.enable = true;
    bundles.tmux.enable = true;
    bundles.editors.enable = true;
    bundles.k8s.enable = true;
    bundles.dev.enable = true;
    bundles.keyboard-layout.enable = true;
    bundles.email.enable = true;
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
