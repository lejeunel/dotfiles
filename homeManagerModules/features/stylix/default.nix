{ pkgs, lib, inputs, ... }: {
  imports = [ inputs.stylix.homeManagerModules.stylix ];
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

    image = ./girl-reading-book.jpg;
    cursor.name = "Bibata-Modern-Ice";
    cursor.package = pkgs.bibata-cursors;

    enable = true;
    autoEnable = true;
    targets.neovim.enable = false;
    targets.rofi.enable = false;
    targets.waybar.enable = false;

    fonts.sizes = { terminal = 15; };
  };
}
