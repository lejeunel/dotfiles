{ inputs, pkgs, lib, config, ... }:

{

  myHomeManager.golang.enable = true;
  myHomeManager.cpp.enable = true;
  myHomeManager.lua.enable = true;
  myHomeManager.nix.enable = true;
  myHomeManager.javascript.enable = true;

}
