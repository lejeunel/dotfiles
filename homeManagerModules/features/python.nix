{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    python311
    ruff-lsp
    inputs.fix-python.packages."x86_64-linux".default
  ];

}
