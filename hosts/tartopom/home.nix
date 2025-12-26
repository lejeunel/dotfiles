{
  outputs,
  pkgs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.desktop.enable = true;
    bundles.hyprland.enable = true;
    bundles.shell.enable = true;
    bundles.editors.enable = true;
    bundles.general.enable = true;
    bundles.dev.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      xorg.setxkbmap
      networkmanager
      ubuntu-classic
      roboto-serif
    ];
  };

}
