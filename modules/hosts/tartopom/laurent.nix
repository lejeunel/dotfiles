{ inputs, ... }:
{
  flake.modules.homeManager."laurent@tartopom" = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
      dev

      drawing
      messaging
      office

      podman
    ];

  };

}
