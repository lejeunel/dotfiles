{ pkgs, ... }:
{
  home.packages = with pkgs; [
    calcurse
    fastfetch
    psmisc
    nh
    pdftk
    imagemagick
    unzip
    lazydocker
    stow
    rsync
    parallel
  ];

  myHomeManager.shell.enable = true;
  myHomeManager.tmux.enable = true;

}
