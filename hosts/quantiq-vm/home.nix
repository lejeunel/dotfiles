{
  outputs,
  pkgs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    bundles.stylix.enable = true;
    bundles.shell.enable = true;
    bundles.dev.enable = true;
    bundles.encryption.enable = true;
  };

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";

    packages = with pkgs; [
      gnumake
    ];
  };

}
