{ lib, pkgs, config, homeDirectory, username, nix-colors, dotfilesPath, ... }:
{

  fonts.fontconfig.enable = true;

  home = {

    homeDirectory = "${homeDirectory}";
    stateVersion = "24.05";
    username = "${username}";

    packages = [
      pkgs.xidlehook
      pkgs.xorg.setxkbmap
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];


  };

  imports = [
    nix-colors.homeManagerModules.default
    ./shell
    ./editors
    ./desktop
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;


  home.file.".local/share/X11/xkb/symbol/us_qwerty_fr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/home/us_qwerty-fr";

}
