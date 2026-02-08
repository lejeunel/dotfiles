{ inputs, ... }:
{
  flake.modules.homeManager.system-desktop =
    { config, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-cli

        firefox
        waybar
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
