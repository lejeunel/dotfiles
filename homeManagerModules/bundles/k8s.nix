{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [ k3s k9s fluxcd gnupg sops yq age kubeval jq ];
}
