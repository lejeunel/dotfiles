{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ ccls gnumake cmake gcc ];

}
