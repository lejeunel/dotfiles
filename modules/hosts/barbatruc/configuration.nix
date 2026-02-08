{ ... }:

{
  flake.modules.nixos.barbatruc =
    { inputs, pkgs, ... }:
    {

      imports = with inputs.self.modules.nixos; [
        users
        locale
        fonts
        systemd-boot
        networking
        nix
        wifi
        ssh
        audio
        greetd
        libinput
        portals
        stylix
        console
        upower
        pcscd
      ];

      networking.hostName = "barbatruc"; # Define your hostname.
      hardware.graphics.enable = true;
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;
      services.thermald.enable = true;
      services.tlp = {
        enable = true;
      };

      # Set your time zone.
      time.timeZone = "Europe/Paris";

      system.stateVersion = "24.05"; # Did you read the comment?

      environment.sessionVariables = {
        LD_LIBRARY_PATH = "$NIX_LD_LIBRARY_PATH";
      };

    };

}
