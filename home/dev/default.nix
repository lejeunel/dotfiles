{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
      python312Packages.python-lsp-ruff
      python312Packages.python-lsp-server
      gopls
    ];

    programs = {
      go = {
        enable = true;
      };
    };

}
