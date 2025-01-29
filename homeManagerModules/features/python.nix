{ config, inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    python311
    python311Packages.python-lsp-server
    python311Packages.isort
    python311Packages.black
    python311Packages.pyflakes
    python311Packages.pylint
    inputs.fix-python.packages."x86_64-linux".default
  ];

  programs.poetry = {
    enable = true;
    settings = {
      virtualenvs.create = true;
      virtualenvs.in-project = true;
    };

  };

}
