{
  outputs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.hyprland.enable = true;
    bundles.editors.enable = true;
    bundles.dev.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
