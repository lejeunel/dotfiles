{
  description = "My NixOS / Home-Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixgl.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nix-colors, home-manager, nixgl, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      extraSpecialArgs = {
        # we bundle in this repo our editors config, these will be
        # linked to $HOME/.config/ from ${HOME}/${editorsCfgPath}
        dotfilesPath = "dotfiles";
        homeDirectory = "/home/laurent";
        username = "laurent";
        font = "JetBrainsMono Nerd Font";
        wallpaper = "~/Pictures/lonely-fish.png";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        gitIdentity = {
          email = "me@lejeunel.org";
          fullname = "Laurent Lejeune";
          username = "lejeunel";
        };
        inherit nix-colors;
      };
    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#<hostname>'
      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/vm/configuration.nix ];
        };
        tartopom = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/tartopom/configuration.nix ];
        };
      };

      # Home-Manager configuration entrypoint
      # Available through 'home-manager --flake .#<user>'
      homeConfigurations = {
        "laurent@tartopom" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit extraSpecialArgs;

          modules = [ ./hosts/tartopom/home.nix ];
        };
      };
    };
}
