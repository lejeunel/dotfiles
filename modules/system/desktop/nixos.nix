{ inputs, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      niri
      portals
      ssh
      wifi
      audio
      libinput
      portals
      pcscd
    ];

  };

}
