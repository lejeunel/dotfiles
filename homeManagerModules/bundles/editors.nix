{ inputs, pkgs, lib, config, ... }:
let lf = "${pkgs.lf}/bin/lf";
in {

  myHomeManager.editors.enable = true;
  home.packages = with pkgs; [ calcurse bluetuith htop neofetch nh psmisc ];

}
