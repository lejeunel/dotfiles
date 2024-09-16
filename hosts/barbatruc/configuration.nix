# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "barbatruc"; # Define your hostname.

  myNixOS = {
    bundles.desktop.enable = true;
    # bundles.xorg.enable = true;
    bundles.wayland.enable = true;
    bundles.users.enable = true;
    bundles.locale.enable = true;
    bundles.audio.enable = true;
    bundles.fonts.enable = true;
    bundles.power.enable = true;
  };

  # Enable OpenGL
  hardware.opengl = { enable = true; };

  # Enable networking
  networking.networkmanager.enable = true;

  # power management
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.tlp = { enable = true; };

  security.polkit.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ neovim wget git gnumake ];

  system.stateVersion = "24.05"; # Did you read the comment?

  environment.sessionVariables = { LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH"; };

}
