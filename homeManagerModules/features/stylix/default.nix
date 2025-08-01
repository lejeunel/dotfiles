{ pkgs, lib, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    base16Scheme = {

      base00 = "292828";
      base01 = "32302f";
      base02 = "504945";
      base03 = "665c54";
      base04 = "bdae93";
      base05 = "ddc7a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "ea6962";
      base09 = "e78a4e";
      base0A = "d8a657";
      base0B = "a9b665";
      base0C = "89b482";
      base0D = "7daea3";
      base0E = "d3869b";
      base0F = "bd6f3e";
    };

    image = ./girl-reading-book.png;
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 28;
    };

    enable = true;
    autoEnable = true;
    targets.neovim.enable = false;
    targets.rofi.enable = false;
    targets.waybar.enable = false;
    targets.hyprland.enable = true;
    targets.firefox = {
      enable = true;
      profileNames = [ "laurent" ];
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.ubuntu_font_family;
        name = "Ubuntu";
      };
      serif = {
        package = pkgs.roboto-serif;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 10;
        popups = 10;
      };
    };

  };
}
