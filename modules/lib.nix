{
  inputs,
  ...
}:
{

  # Helper functions for creating system / home-manager configurations

  config.flake.lib = {

    mkHome =
      sys: name: host:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${sys};
        extraSpecialArgs = {
          vars = {
            host = host;
          };
          inherit inputs;
        };
        modules = [
          inputs.self.modules.homeManager."${name}@${host}"

          {
            nixpkgs.config.allowUnfree = true;
            home = {
              username = "laurent";
              homeDirectory = "/home/laurent";
              stateVersion = "24.05";
            };
          }
        ];
      };

    mkSystem =
      name:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.self.modules.nixos.${name}
        ];
      };

  };
}
