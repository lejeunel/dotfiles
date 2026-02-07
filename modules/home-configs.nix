{ inputs, ... }:
let
  # provide the mkHome function
  myLib = import ./myLib/default.nix { inherit inputs; };
in
with myLib;
{
  # Home-Manager configuration entrypoint
  # Available through 'home-manager --flake .#<user>'
  flake.homeConfigurations = {
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

}
