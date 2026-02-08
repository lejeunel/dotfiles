{
  flake.modules.nixos.wifi =
    { inputs, config, ... }:
    {
      networking.wireless = {
        networks = {
          freebox-363c77.psk = "ext:freebox-363c77";
        };
      };

    };
}
