{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    yarn
    nodejs_20
    inputs.fix-python.packages."x86_64-linux".default
  ];

}
