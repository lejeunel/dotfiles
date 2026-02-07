{ ... }:

{
  flake.modules.homeManager.hyprpaper =
    { pkgs, ... }:
    {
      services.hyprpaper = {
        enable = true;
      };
      home.packages = with pkgs; [
        hyprpaper # Ensure this package exists in your nixpkgs
      ];
    };
}
