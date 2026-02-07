{ outputs, ... }:
{

  imports = [
    outputs.homeManagerModules.default
  ];

  myHomeManager = {
    bundles.niri.enable = true;
    bundles.desktop.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
    bundles.k8s.enable = true;
    bundles.dev.enable = true;
    bundles.keyboard-layout.enable = true;
    bundles.email.enable = true;
    bundles.encryption.enable = true;
    bundles.bluetooth.enable = true;
    bundles.wifi.enable = true;
    bundles.tmux.enable = true;
    bundles.python.enable = true;
    bundles.podman.enable = true;
    bundles.stylix.enable = true;
    bundles.qute.enable = true;
    bundles.floorp.enable = true;
  };
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
