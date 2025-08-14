{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ k3s k9s yq jq ];
}
