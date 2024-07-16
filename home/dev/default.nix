{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python312Packages.python-lsp-server

    python312Packages.python-lsp-ruff
    python312Packages.black
    python312Packages.isort
    python312Packages.pyflakes

    # golang utils
    gopls
    godef
    gomodifytags
    gotests
    gore
    gotools

  ];

  programs = {
    ruff = {
      enable = true;
      settings = {
        line-length = 100;
        per-file-ignores = { "__init__.py" = [ "F401" ]; };
        lint = {
          select = [ "E4" "E7" "E9" "F" ];
          ignore = [ ];
        };
      };
    };
    go = { enable = true; };
  };

}
