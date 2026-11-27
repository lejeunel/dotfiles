{ ... }:

{
  flake.modules.nixos.barbidul =
    { inputs, ... }:
    {

      imports = with inputs.self.modules.nixos; [
        system-desktop

      ];

      networking.hostName = "barbidul"; # Define your hostname.
      hardware.graphics.enable = true;
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;
      services.thermald.enable = true;
      # services.tlp.enable = true;

      # Power key is handled by logind rather than niri (see laurent.nix).
      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
      };

      # Set your time zone.
      time.timeZone = "Europe/Paris";

      system.stateVersion = "26.05"; # Did you read the comment?

      environment.sessionVariables = {
        LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH";
      };

    };

}
