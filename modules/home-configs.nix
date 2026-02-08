{ inputs, ... }:
{
  # Home-Manager configuration entrypoint
  # Available through 'home-manager --flake .#<user>'
  flake.homeConfigurations = {
    "laurent@tartopom" = inputs.self.lib.mkHome "x86_64-linux" "laurent" "tartopom";
    "laurent@barbatruc" = inputs.self.lib.mkHome "x86_64-linux" "laurent" "barbatruc";
    "laurent@quantiq-vm" = inputs.self.lib.mkHome "x86_64-linux" "laurent" "quantiq-vm";
  };

}
