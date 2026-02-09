{ inputs, ... }:
{
  flake.modules.homeManager."laurent@quantiq-vm" = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      dev

      podman
      filebrowser

    ];

  };

}
