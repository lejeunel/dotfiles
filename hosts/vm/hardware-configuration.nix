{config, lib, pkgs, modulesPath, ...}:

{
  imports = [];

  boot.initrd.availableKernelModules = [
                                        "ohci_pci"
                                        "ehci_pci"
                                        "usb_storage"
                                        "ahci"
                                        "sd_mod"
                                        "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

}
