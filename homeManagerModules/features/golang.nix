{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    gotools
    gomodifytags
    gocode-gomod
    gotestsum
    gotest
  ];

}
