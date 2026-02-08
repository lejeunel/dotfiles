{ inputs, ... }:
{
  # NixOS configuration entrypoint
  # Available through 'nixos-rebuild --flake .#<hostname>'
  flake.nixosConfigurations = {
    tartopom = inputs.self.lib.mkSystem "tartopom";
    barbatruc = inputs.self.lib.mkSystem "barbatruc";
  };
}
