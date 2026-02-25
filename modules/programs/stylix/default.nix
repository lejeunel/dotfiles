{ inputs, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; # or your system architecture
  base16Scheme = {
    base00 = "24273a";
    base01 = "1e2030";
    base02 = "363a4f";
    base03 = "494d64";
    base04 = "5b6078";
    base05 = "cad3f5";
    base06 = "f4dbd6";
    base07 = "b7bdf8";
    base08 = "ed8796";
    base09 = "f5a97f";
    base0A = "eed49f";
    base0B = "a6da95";
    base0C = "8bd5ca";
    base0D = "8aadf4";
    base0E = "c6a0f6";
    base0F = "f0c6c6";
  };
  cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 28;
  };
  image = ./cat-sound.png;
  sizes = {
    applications = 12;
    terminal = 15;
    desktop = 10;
    popups = 10;
  };
  fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    sansSerif = {
      package = pkgs.ubuntu-classic;
      name = "Ubuntu";
    };
    serif = {
      package = pkgs.roboto-serif;
      name = "DejaVu Serif";
    };

    sizes = sizes;

  };

in
{
  flake.modules.nixos.stylix = {

    imports = [
      inputs.stylix.nixosModules.stylix
    ];
    stylix = {

      enable = true;
      base16Scheme = base16Scheme;
      fonts = fonts;
      cursor = cursor;

      targets.plymouth.enable = true;
      targets.nixos-icons.enable = true;
    };

  };

  flake.modules.homeManager.stylix =
    {
      inputs,
      ...
    }:
    {

      imports = [ inputs.stylix.homeModules.stylix ];
      stylix = {
        base16Scheme = base16Scheme;
        cursor = cursor;
        image = image;
        fonts = fonts;

        enable = true;
        targets.neovim.enable = false;
        targets.rofi.enable = false;
        targets.waybar.enable = false;
        targets.emacs.enable = false;
        targets.firefox = {
          enable = true;
          profileNames = [ "laurent" ];
        };

      };
    };
}
