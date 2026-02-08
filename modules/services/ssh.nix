{

  flake.modules.nixos.ssh =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ sshfs ];

    };

}
