{ ... }:

{
  flake.modules.nixos.ulahup =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
	  imports =
	    [ (modulesPath + "/installer/scan/not-detected.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "sd_mod" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ "kvm-intel" ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/disk/by-uuid/a9512014-e8e1-4b70-9968-05df53d8580c";
	      fsType = "ext4";
	    };

	  fileSystems."/boot" =
	    { device = "/dev/disk/by-uuid/AE8D-00AB";
	      fsType = "vfat";
	      options = [ "fmask=0077" "dmask=0077" ];
	    };

	  swapDevices =
	    [ { device = "/dev/disk/by-uuid/82a7ac3f-f629-44c8-a56a-79beb47fc855"; }
	    ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

	    };
}
