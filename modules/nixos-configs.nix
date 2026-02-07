{ inputs, ... }:
{
  # NixOS configuration entrypoint
  # Available through 'nixos-rebuild --flake .#<hostname>'
  flake.nixosConfigurations = {
    tartopom = inputs.self.lib.mkSystem ./hosts/tartopom/configuration.nix;
    barbatruc = inputs.self.lib.mkSystem ./hosts/barbatruc/configuration.nix;
  };
}
