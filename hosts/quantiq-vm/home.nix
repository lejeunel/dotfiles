{
  outputs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.dev.enable = true;
    bundles.encryption.enable = true;
    bundles.emacs.enable = true;
    bundles.remote.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
