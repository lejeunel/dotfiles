{ pkgs, ... }:

{
  # Enable hyprpaper
  services.hyprpaper = { enable = true; };

  # If hyprpaper isn't in nixpkgs, add it manually
  home.packages = with pkgs;
    [
      hyprpaper # Ensure this package exists in your nixpkgs
    ];
}
