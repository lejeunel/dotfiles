{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python311
    Python311Packages.python-lsp-server
    Python311Packages.python-lsp-ruff
    Python311Packages.isort
  ];

}
