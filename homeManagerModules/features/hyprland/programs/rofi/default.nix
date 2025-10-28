{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      kb-remove-to-eol = "";
      kb-remove-char-back = "BackSpace,Shift+BackSpace";
      kb-mode-complete = "";
      kb-accept-entry = "Return";
      kb-row-down = "Control+j";
      kb-row-up = "Control+k";
      kb-row-right = "Control+l";
      kb-row-left = "Control+h";
    };
    plugins = with pkgs; [
      rofi-emoji-wayland # https://github.com/Mange/rofi-emoji 🤯
    ];
  };
  xdg.configFile."rofi/launchers" = {
    source = ./launchers;
    recursive = true;
  };
  xdg.configFile."rofi/colors" = {
    source = ./colors;
    recursive = true;
  };
  xdg.configFile."rofi/assets" = {
    source = ./assets;
    recursive = true;
  };
  xdg.configFile."rofi/resolution" = {
    source = ./resolution;
    recursive = true;
  };
}
