{ pkgs, ... }:
{
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ pulsemixer ];

  # battery
  services.upower.enable = true;
  services.upower.ignoreLid = true;
}
