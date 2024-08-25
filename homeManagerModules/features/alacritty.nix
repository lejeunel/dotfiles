{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      font = {
        size = 13;
        normal.family = "JetBrainsMono Nerd Font";
      };
      window.padding = {
        x = 10;
        y = 10;
      };
      env.term = "xterm-256color";

    };
  };

}
