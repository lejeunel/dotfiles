{ inputs, ... }:
{
  flake.modules.homeManager.system-cli = {
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
      nvim
      stylix
      sops
      email
      gpg
    ];
  };

}
