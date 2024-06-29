{ lib, pkgs, config, homeDirectory, username, nix-colors, ... }:
{

  home = {

    homeDirectory = "${homeDirectory}";
    stateVersion = "24.05";
    username = "${username}";

  };

  imports = [
    nix-colors.homeManagerModules.default
    ./shell
    ./editors
    ./desktop
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;

}
