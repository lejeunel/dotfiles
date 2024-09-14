{ pkgs, lib, ... }: {
  myNixOS.wayland.enable = true;
  myNixOS.bluetooth.enable = true;
  myNixOS.stylix.enable = true;

  # Central European time zone
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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
      fonts = [ "JetBrainsMono" "Iosevka" "FiraCode" ];
    })
    cm_unicode
    corefonts
  ];

  # battery
  services.upower.enable = true;
  services.upower.ignoreLid = true;
}
