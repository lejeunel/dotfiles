{ inputs, ... }:
let
  # provide the mkSystem function
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
