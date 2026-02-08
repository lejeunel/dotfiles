{
  ...
}:

{
  flake.modules.nixos.networking = {
    networking = {
      networkmanager.enable = true;
      wireless.iwd.enable = true;
      networkmanager.wifi.backend = "iwd";
      wireless.iwd.settings.Settings.AutoConnect = true;
    };
  };
}
