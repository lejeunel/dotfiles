{
  description = "My Home Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, alacritty-theme, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        laurent = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ({ config, pkgs, ...}: {
              # install the overlay
              nixpkgs.overlays = [ alacritty-theme.overlays.default ];
            })
            ./home.nix ];
      };
    };
  };
}

