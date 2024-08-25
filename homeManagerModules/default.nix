{ inputs, outputs, lib, pkgs, config, homeDirectory, username, nix-colors, ...
}: {

  imports = [ outputs.homeManagerModules.default ];

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

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

}
