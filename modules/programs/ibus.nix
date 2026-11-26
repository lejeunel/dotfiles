{
  flake.modules.nixos.ibus =
    { config, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "ibus";
      };

      systemd.user.services.ibus-daemon = {
        description = "IBus input method daemon";
        bindsTo = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "dbus";
          BusName = "org.freedesktop.IBus";
          ExecStart = "${config.i18n.inputMethod.package}/bin/ibus-daemon --replace --panel disable --xim";
          Restart = "on-failure";
          Slice = "session.slice";
        };
      };
    };
}
