{ inputs, pkgs, lib, config, ... }: {

  myHomeManager.editors.enable = true;
  home.packages = with pkgs; [ calcurse bluetuith htop neofetch nh psmisc ];

}
