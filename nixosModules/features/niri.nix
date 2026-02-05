{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  programs.niri.enable = true;
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
  environment.variables.NIXOS_OZONE_WL = "1";

  # Required for Wayland compositors
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.seatd.enable = true;

  # Optional but recommended
  security.polkit.enable = true;

  # Fonts (niri needs at least one font)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  environment.systemPackages = with pkgs; [
    wdisplays
  ];
}
