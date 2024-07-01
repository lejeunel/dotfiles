# Udon -- my primary powerhouse

{ self, lib, ... }:

with lib;
with builtins;
{
  system = "x86_64-linux";

  modules = {
    xdg.ssh.enable = true;

    profiles = {
      user = "laurent";
      networks = [ "ca" ];
      hardware = [
        "cpu/amd"
        "gpu/nvidia"
      ];
    };

    desktop = {
      # X only
      # bspwm.enable = true;
      # term.default = "xst";
      # term.st.enable = true;

      term.default = "alacritty";
      term.alacritty.enable = true;

      ## Extra
      apps.rofi.enable = true;
      browsers.default = "firefox";
      browsers.firefox.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      tmux.enable = true;
      zsh.enable = true;
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

  };

  hardware = { ... }: {

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
        options = [ "noatime" "errors=remount-ro" ];
      };
      "/boot" = {
        device = "/dev/disk/by-label/BOOT";
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
