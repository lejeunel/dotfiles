{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      window.padding = {
        x = 10;
        y = 10;
      };

      keyboard.bindings = [{
        key = "Space";
        mods = "Control";
        action = "ToggleViMode";
      }];

    };
  };

}
