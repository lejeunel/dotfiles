{ inputs, outputs, pkgs, lib, ... }: {

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.desktop.enable = true;
    bundles.shell.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = lib.mkDefault "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      xorg.setxkbmap
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ];
      })
      networkmanager
    ];
  };
}
