{ config, lib, pkgs, ... }:

{
  systemd.user.services.rclone-mounts = {
    Unit = {
      Description =
        "Example programmatic mount configuration with nix and home-manager.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "/usr/bin/env mkdir -p %h/remote";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone --config=%h/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount "gdrive:" "Google Drive"'';
      ExecStop = "/bin/fusermount -u %h/remote/%i";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
