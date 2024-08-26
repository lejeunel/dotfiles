{ config, lib, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Oranchelo";
      show-icons = true;
      hide-scrollbar = "true";

      drun-display-format = "{icon} {name}";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
      disable-history = false;

      kb-remove-to-eol = "Control+Shift+e";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "";
      kb-accept-entry = "Return";
      kb-row-up = "Up,Control+k";
      kb-row-down = "Down,Control+j";
      kb-mode-next = "Control+l";
      kb-mode-previous = "Control+h";

    };
  };

}
