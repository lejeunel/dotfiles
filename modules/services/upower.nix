{
  flake.modules.nixos.upower = {
    services.upower.enable = true;
    services.upower.ignoreLid = true;

  };

}
