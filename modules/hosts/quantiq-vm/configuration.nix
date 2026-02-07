{
  lib,
  config,
  pkgs,
  ...
}:

{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "quantiq-vm";

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (
      config.nix.package == pkgs.nixFlakes
    ) "experimental-features = nix-command flakes";
  };

}
