{
  flake.modules.nixos.portals =
    { pkgs, ... }:
    {

      xdg.portal = {
        enable = true;
        config = {
          common = {
            default = [ "gtk" ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
          };
        };

        # Add extra portals here
        extraPortals = [
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    };

}
