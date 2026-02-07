{
  pkgs,
  ...
}:
{

  myHomeManager.office.enable = true;
  myHomeManager.stylix.enable = true;
  myHomeManager.messaging.enable = true;

  home.packages = with pkgs; [
    dconf
    nautilus
    gnome-screenshot
    gnome-calculator
    vlc
    transmission_4-gtk
  ];

  services.grobi = {
    enable = true;
    executeAfter = [ "${pkgs.systemd}/bin/systemctl --user restart polybar" ];
    rules = [
      {
        name = "Dual";
        outputs_connected = [
          "HDMI-2"
          "eDP-1"
        ];
        configure_row = [
          "HDMI-2"
          "eDP-1"
        ];
        primary = "HDMI-2";
      }
      {
        name = "Mobile";
        outputs_connected = [ "eDP-1" ];
        outputs_disconnected = [ "HDMI-2" ];
        configure_single = "eDP-1";
        primary = true;
        atomic = true;
      }
    ];
  };

}
