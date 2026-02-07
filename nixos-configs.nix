{ inputs, ... }:
let
  # super simple boilerplate-reducing
  # lib with a bunch of functions
  myLib = import ./myLib/default.nix { inherit inputs; };
in
with myLib;
{
  # NixOS configuration entrypoint
  # Available through 'nixos-rebuild --flake .#<hostname>'
  flake.nixosConfigurations = {
    tartopom = mkSystem ./hosts/tartopom/configuration.nix;
    barbatruc = mkSystem ./hosts/barbatruc/configuration.nix;
  };
}
