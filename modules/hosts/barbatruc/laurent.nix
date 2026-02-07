{ inputs, ... }:
{
  flake.modules.homeManager."laurent@barbatruc" = {
    imports = with inputs.self.modules.homeManager; [
      tmux
      git
      alacritty
      firefox
      imv
      shell
      bluetooth
      drawing
      direnv
      cpp
      waybar
      wlogout
      wifi
      zathura

      niri
      hypridle
      hyprpaper
      hyprlock
      rofi
      swaync

      podman
      python

      filebrowser

      golang
      gpg
      gtk
      javascript
      guile

      qwerty-fr

      messaging
      office
    ];

  };

}
