{ pkgs, ... }:

{
  programs.niri.enable = true;

  # Required for Wayland compositors
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Seat management (pick ONE)
  services.seatd.enable = true;
  # OR:
  # services.logind.enable = true;

  # Optional but recommended
  security.polkit.enable = true;

  # Fonts (niri needs at least one font)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];
}
