{ pkgs, lib, ... }: {
  myNixOS.wayland.enable = true;
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

  environment.systemPackages = with pkgs; [ nwg-displays brightnessctl ];
  xdg.portal = {
    enable = true;
    wlr.enable = true; # adds pkgs.xdg-desktop-portal-wlr to extraPortals
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk # gtk portal needed to make gtk apps happy
    ];
  };

}
