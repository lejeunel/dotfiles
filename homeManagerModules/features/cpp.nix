{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ccls
    gnumake
    cmake
    gcc
  ];

}
