{
  flake.modules.nixos.networking = {
    networking = {
      wireless.iwd.enable = true;
      networkmanager.wifi.backend = "iwd";
      wireless.iwd.settings.Settings.AutoConnect = true;
    };
  };
}
