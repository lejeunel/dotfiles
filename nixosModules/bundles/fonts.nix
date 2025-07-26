{ config, lib, pkgs, ... }:

{

  fonts.packages = [
	  pkgs.nerd-fonts.jetbrains-mono
    pkgs.cm_unicode
    pkgs.corefonts
  ];
}
