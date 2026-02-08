{ pkgs, ... }:
{
  myNixOS.wayland.enable = true;
  myNixOS.stylix.enable = true;

  environment.systemPackages = with pkgs; [
    nwg-displays
    brightnessctl
    libinput
  ];
  xdg.portal = {
    enable = true;
    # Disable wlr portal (conflicts with Hyprland’s own)
    wlr.enable = false;

    # Add extra portals here
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

}
