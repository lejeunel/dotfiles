{ inputs, outputs, pkgs, lib, ... }: {

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.desktop.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
    bundles.general.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      xorg.setxkbmap
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ];
      })
      networkmanager
    ];
  };

  programs.home-manager.enable = true;
}
