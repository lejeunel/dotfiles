{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ nixd ];
}
