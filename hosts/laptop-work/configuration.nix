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

  networking.hostName = "PC-JSCANVIC-2"; # Define your hostname.

  virtualisation.docker.enable = true;

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
