{ inputs, outputs, pkgs, lib, ... }: {

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.shell.enable = true;
    bundles.tmux.enable = true;
    bundles.editors.enable = true;
    # bundles.stylix.enable = true;
    bundles.dev.enable = true;
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
      ubuntu_font_family
      roboto-serif
    ];
  };

}
