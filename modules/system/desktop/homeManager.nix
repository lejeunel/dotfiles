{ inputs, ... }:
{
  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli

      firefox
      chrome
      zathura
      nautilus
      niri
      hypridle
      hyprlock
      rofi
      gtk
    ];
  };

}
