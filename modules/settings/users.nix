{ ... }:
{
  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;

      users.groups.uinput = { };
      services.udev.extraRules = ''
        KERNEL=="uinput", OPTIONS+="static_node=uinput", GROUP="uinput", MODE="0660"
      '';

      users.users.laurent = {
        isNormalUser = true;
        home = "/home/laurent";
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
          "keyd"
          "uinput"
          "input"
        ];
        shell = pkgs.zsh;
      };

    };

}
