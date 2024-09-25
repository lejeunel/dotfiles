{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      window.padding = {
        x = 10;
        y = 10;
      };
      keyboard.bindings = [{
        key = "v";
        mods = "Control";
        action = "ToggleViMode";
      }];

      env.TERM = "alacritty-direct";
    };
  };

}
