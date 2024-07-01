# Udon -- my primary powerhouse

{ self, lib, ... }:

with lib;
with builtins;
{
  system = "x86_64-linux";

  modules = {
    profiles = {
      role = "vm";
      user = "laurent";
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

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
        options = [ "noatime" "errors=remount-ro" ];
      };
      "/boot" = {
        device = "/dev/disk/by-label/boot";
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
