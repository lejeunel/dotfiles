{
  flake.modules.nixos.dms-greeter = {
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };

  };

}
