{
  flake.modules.nixos.dux-greeter = {
    services.displayManager.dux-greeter = {
      enable = true;
      compositor.name = "niri";
    };

  };

}
