{ pkgs, lib, ... }: {
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ pulsemixer ];

  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [ "JetBrainsMono" "Iosevka" "FiraCode" "NerdFontsSymbolsOnly" ];
    })
    cm_unicode
    corefonts
  ];

  # battery
  services.upower.enable = true;
  services.upower.ignoreLid = true;
}
