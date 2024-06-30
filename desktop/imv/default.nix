{ config, lib, pkgs, ... }:

{
  programs.imv = {
    enable = true;
    settings = {
      options.suppress_default_binds = true;
      binds = {
        "<Escape>" = "quit";
        "q" = "quit";

        "<Left>" = "prev";
        "<Right>" = "next";
        "<Ctrl+k>" = "prev 1";
        "<Ctrl+j>" = "next 1";
        "gg" = "goto 1";
        "<Shift+G>" = "goto -1";

        "j" = "pan 0 -50";
        "k" = "pan 0 50";
        "h" = "pan 50 0";
        "l" = "pan -50 0";

        "<Ctrl+r>" = "rotate by 90";

        "f" = "fullscreen";
        "a" = "zoom actual";
        "r" = "reset";
      };
    };
  };
 
}
