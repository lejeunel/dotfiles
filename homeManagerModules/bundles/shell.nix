{ pkgs, ... }:
{
  home.packages = with pkgs; [
    calcurse
    fastfetch
    psmisc
    htop
    nh
    pdftk
    imagemagick
    unzip
    lazydocker
  ];

  myHomeManager.shell.enable = true;
  myHomeManager.tmux.enable = true;

}
