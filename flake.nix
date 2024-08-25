{
  description = "My NixOS / Home-Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixgl.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { ... }@inputs:
    let
      # super simple boilerplate-reducing
      # lib with a bunch of functions
      myLib = import ./myLib/default.nix { inherit inputs; };
    in with myLib; {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#<hostname>'
      nixosConfigurations = {
        vm = mkSystem ./hosts/vm/configuration.nix;
        tartopom = mkSystem ./hosts/tartopom/configuration.nix;
      };

      # Home-Manager configuration entrypoint
      # Available through 'home-manager --flake .#<user>'
      homeConfigurations = {
        "laurent@tartopom" = mkHome "x86_64-linux" ./hosts/tartopom/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;

    };
}
