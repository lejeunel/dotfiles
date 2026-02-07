{ inputs, ... }:
{
  # Home-Manager configuration entrypoint
  # Available through 'home-manager --flake .#<user>'
  flake.homeConfigurations = {
    "laurent@tartopom" = inputs.self.lib.mkHome {
      sys = "x86_64-linux";
      host = "tartopom";
    } ./hosts/tartopom/home.nix;
    "laurent@barbatruc" = inputs.self.lib.mkHome {
      sys = "x86_64-linux";
      host = "barbatruc";
    } ./hosts/barbatruc/home.nix;
    "laurent@quantiq-vm" = inputs.self.lib.mkHome {
      sys = "x86_64-linux";
      host = "quantiq-vm";
    } ./hosts/quantiq-vm/home.nix;
  };

}
