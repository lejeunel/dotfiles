{
  flake.modules.homeManager.mount =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rclone
      ];


      systemd.user.services.dropbox-mount = {
        Unit = {
          Description = "Mount Dropbox via rclone";
          After = [ "network-online.target" ];
        };
        Service = {
          Type = "notify";
          Environment = [ "PATH=/run/wrappers/bin" ]; 
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Dropbox";
          ExecStart = "${pkgs.rclone}/bin/rclone mount dropbox: %h/Dropbox --vfs-cache-mode full";
          ExecStop = "/run/wrappers/bin/fusermount -u %h/Dropbox";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "default.target" ];
      };
      
    };

}
