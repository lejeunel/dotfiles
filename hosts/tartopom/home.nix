{ inputs, outputs, pkgs, lib, nix-colors, ... }: {

  imports = [
    outputs.homeManagerModules.default
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

  myHomeManager = {
    bundles.desktop.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
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
