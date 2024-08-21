{ lib, pkgs, config, homeDirectory, username, nix-colors, dotfilesPath
, fix-python, ... }: {

  fonts.fontconfig.enable = true;

  home = {

    homeDirectory = "${homeDirectory}";
    stateVersion = "24.05";
    username = "${username}";

    packages = with pkgs; [
      xorg.setxkbmap
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ];
      })
      networkmanager
    ];

  };

  imports =
    [ nix-colors.homeManagerModules.default ./shell ./editors ./desktop ];

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

}
