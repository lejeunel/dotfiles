{ ... }:

{
  flake.modules.nixos.xserver = {

    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.xterm.enable = true;
      windowManager.i3.enable = true;
      xkb.layout = "us";
      xkb.variant = "intl";
      libinput = {
        enable = true;
        naturalScrolling = true;
      };
    };

    console.useXkbConfig = true;
  };

}
