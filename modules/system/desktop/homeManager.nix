{ inputs, ... }:
{
  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli

      firefox
      chrome
      zathura
      pcmanfm
      niri
      hypridle
      hyprpaper
      hyprlock
      rofi
      gtk
    ];
  };

}
