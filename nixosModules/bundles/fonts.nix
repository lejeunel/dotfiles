{ config, lib, pkgs, ... }:

{

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.symbols-only
    pkgs.cm_unicode
    pkgs.corefonts
  ];
}
