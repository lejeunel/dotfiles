{ outputs, ... }:
{

  imports = [
    outputs.homeManagerModules.default
  ];

  myHomeManager = {
    bundles.email.enable = true;
  };
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
