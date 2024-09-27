{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ luaformatter lua-language-server ];
}
