{ ... }:

{
  flake.modules.nixos.barbatruc =
    { inputs, pkgs, ... }:
    {

      imports = with inputs.self.modules.nixos; [
        wifi
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "barbatruc"; # Define your hostname.

      myNixOS = {
        bundles.desktop.enable = true;
        bundles.console.enable = true;
        bundles.ccid.enable = true;
        bundles.wayland.enable = true;
        bundles.users.enable = true;
        bundles.locale.enable = true;
        bundles.audio.enable = true;
        bundles.fonts.enable = true;
        bundles.power.enable = true;
      };

      # Enable OpenGL
      hardware.graphics.enable = true;

      # Enable networking
      networking.networkmanager.enable = true;
      networking.wireless.iwd.enable = true;
      networking.networkmanager.wifi.backend = "iwd";
      networking.wireless.iwd.settings.Settings.AutoConnect = true;

      # for playing around with k3s
      networking.extraHosts = ''
        127.0.0.1 podinfo.local
        127.0.0.1 auth.local
      '';

      # power management
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;
      services.thermald.enable = true;
      services.tlp = {
        enable = true;
      };

      security.polkit.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Paris";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        neovim
        wget
        git
        gnumake
      ];

      system.stateVersion = "24.05"; # Did you read the comment?

      environment.sessionVariables = {
        LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH";
      };

    };

}
