{ inputs, ... }:
{
  flake.modules.homeManager."laurent@barbatruc" = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop

      dev

      drawing
      messaging
      office

      podman
      filebrowser

    ];

  };

}
