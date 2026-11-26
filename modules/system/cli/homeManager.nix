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
      emacs
      nvim
      stylix
      gpg

      archive
      mount
    ];

    # let fontconfig find fonts installed via home.packages
    fonts.fontconfig.enable = true;
  };

}
