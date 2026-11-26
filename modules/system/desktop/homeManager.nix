{ inputs, ... }:
{
  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli

      firefox
      emacs-keys
      chrome
      zathura
      nautilus
      niri
      rofi
      gtk
    ];
  };

}
