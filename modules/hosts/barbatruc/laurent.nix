{ inputs, ... }:
{
  flake.modules.homeManager."laurent@barbatruc" = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop

      qwerty-fr

      dev

      aws

      drawing
      messaging
      office

      podman
      filebrowser

    ];

  };

}
