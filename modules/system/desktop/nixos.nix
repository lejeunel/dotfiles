{ inputs, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      wlogout
      zathura
      niri
      hypridle
      hyprpaper
      hyprlock
      rofi
      swaync
      gtk
    ];

  };

}
