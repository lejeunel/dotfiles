{
  description = "My Home Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nix-colors, home-manager, ... } @inputs:
    let

      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # FIXME replace with your hostname
        tartopom = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./nixos/configuration.nix
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };


      homeConfigurations = {
        laurent = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home/home.nix ];
          extraSpecialArgs = {
            # we bundle in this repo our editors config, these will be
            # linked to $HOME/.config/ from ${HOME}/${editorsCfgPath}
            dotfilesPath = "home/dotfiles";
            homeDirectory = "/home/laurent";
            username = "laurent";
            font = "JetBrainsMono Nerd Font";
            wallpaper = "~/Pictures/catppuccin-wallpapers/misc/lonely-fish.png";
            gitIdentity = {
              email = "me@lejeunel.org";
              fullname = "Laurent Lejeune";
              username = "lejeunel";
            };
            inherit nix-colors;

          };
      };
    };
  };
}

