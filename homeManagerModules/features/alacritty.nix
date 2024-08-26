{ config, lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {

      window.padding = {
        x = 10;
        y = 10;
      };
      env.term = "xterm-256color";

    };
  };

}
