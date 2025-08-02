{ pkgs, lib, terminal, ... }: {
  programs.rofi = let inherit (lib) getExe;
  in {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      kb-remove-to-eol = ""; # Often uses Ctrl+j/k
      kb-accept-entry = "Return"; # Clear if needed
      kb-row-down = "Control+j";
      kb-row-up = "Control+k";
    };
    plugins = with pkgs;
      [
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
