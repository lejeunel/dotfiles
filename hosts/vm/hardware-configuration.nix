{config, lib, pkgs, modulesPath, ...}:

{
  imports = [];

  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.initrd.availableKernelModules = ["ata_piix"
                                        "ohci_pci"
                                        "ehci_pci"
                                        "ahci"
                                        "sd_mod"
                                        "sr_mod"];
  boot.initrd.KernelModules = [];
  boot.KernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.virtualbox.guest.enable = true;

}
