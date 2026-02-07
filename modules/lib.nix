{
  inputs,
  ...
}:
let
  myLib = (import ./../myLib/default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
{

  # Helper functions for creating system / home-manager configurations

  config.flake.lib = {

    mkHome =
      x: config:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${x.sys};
        extraSpecialArgs = {
          vars = {
            host = x.host;
          };
          inherit inputs myLib outputs;
        };
        modules = [
          config
          outputs.homeManagerModules.default
          inputs.self.modules.homeManager."${x.name}@${x.host}"
        ];
      };

    mkSystem =
      config:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs myLib; };
        modules = [
          config
          outputs.nixosModules.default
        ];
      };

  };
}
