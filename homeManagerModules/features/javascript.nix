{ pkgs, ... }:

{
  home.packages = with pkgs; [
    yarn
    nodejs_20
  ];

}
