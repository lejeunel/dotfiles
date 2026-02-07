{
  outputs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.stylix.enable = true;
    bundles.shell.enable = true;
    bundles.dev.enable = true;
    bundles.encryption.enable = true;
    bundles.nvim.enable = true;
    bundles.emacs.enable = true;
    bundles.python.enable = true;
    bundles.remote.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
