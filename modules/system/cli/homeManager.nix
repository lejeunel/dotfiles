{ inputs, ... }:
{
  flake.modules.homeManager.system-cli =
    { config, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-base

        tmux
        git
        alacritty
        imv
        shell
        bluetooth
        wifi
        qwerty-fr
        emacs
        stylix
        sops
        email
        gpg
      ];
    };

}
