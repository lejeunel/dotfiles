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
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    # https://flake.parts/module-arguments.html
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          ./modules/lib.nix
          ./modules/home-configs.nix
          ./modules/nixos-configs.nix
        ];
        flake = {
          homeManagerModules.default = ./homeManagerModules;
          nixosModules.default = ./nixosModules;

        };
        systems = [
          "x86_64-linux"
        ];
      }
    );
}
