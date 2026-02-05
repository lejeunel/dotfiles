{
  description = "My NixOS / Home-Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
    };
  };

  outputs =
    { ... }@inputs:
    let
      # super simple boilerplate-reducing
      # lib with a bunch of functions
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    with myLib;
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#<hostname>'
      nixosConfigurations = {
        vm = mkSystem ./hosts/vm/configuration.nix;
        tartopom = mkSystem ./hosts/tartopom/configuration.nix;
        barbatruc = mkSystem ./hosts/barbatruc/configuration.nix;
        ptw11 = mkSystem ./hosts/ptw11/configuration.nix;
      };

      # Home-Manager configuration entrypoint
      # Available through 'home-manager --flake .#<user>'
      homeConfigurations = {
        "laurent@tartopom" = mkHome {
          sys = "x86_64-linux";
          host = "tartopom";
        } ./hosts/tartopom/home.nix;
        "laurent@barbatruc" = mkHome {
          sys = "x86_64-linux";
          host = "barbatruc";
        } ./hosts/barbatruc/home.nix;
        "laurent@quantiq-vm" = mkHome {
          sys = "x86_64-linux";
          host = "quantiq-vm";
        } ./hosts/quantiq-vm/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;

    };
}
