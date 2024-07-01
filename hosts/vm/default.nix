# Udon -- my primary powerhouse

{ self, lib, ... }:

with lib;
with builtins;
{
  system = "x86_64-linux";

  modules = {
    xdg.ssh.enable = true;

    profiles = {
      role = "vm";
      user = "laurent";
      hardware = [
        "cpu/amd"
        "ssd"
      ];
    };

    desktop = {
      # X only
      i3.enable = true;
      term.default = "alacritty";
      term.alacritty.enable = true;


      browsers.default = "firefox";
      browsers.firefox.enable = true;
      media.cad.enable = true;
      media.daw.enable = true;
      media.graphics.enable = true;
    };
    dev = {
      cc.enable = true;
    };
    services = {
      ssh.enable = true;
      docker.enable = true;
    };
    system = {
      utils.enable = true;
      fs.enable = true;
    };
  };

  ## local config
  config = { pkgs, ... }: {

    user.packages = with pkgs; [
      # list of packages here
    ];
  };

  hardware = { ... }: {
    boot.supportedFilesystems = [ "ntfs" ];

    networking.interfaces.eno1.useDHCP = true;

    # Disable all USB wakeup events to ensure restful sleep. This system has
    # many peripherals attached to it (shared between Windows and Linux) that
    # can unpredictably wake it otherwise.
    systemd.services.fixSuspend = {
      script = ''
        for ev in $(grep enabled /proc/acpi/wakeup | cut --delimiter=\  --fields=1); do
           echo $ev > /proc/acpi/wakeup
        done
      '';
      wantedBy = [ "multi-user.target" ];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
        options = [ "noatime" "errors=remount-ro" ];
      };
      "/boot" = {
        device = "/dev/sda1";
        fsType = "vfat";
      };
      "/home" = {
        device = "/dev/disk/by-label/home";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };
    swapDevices = [];
  };
}
