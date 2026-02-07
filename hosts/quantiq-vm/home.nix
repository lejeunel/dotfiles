{
  outputs,
  ...
}:
{

  imports = [ outputs.homeManagerModules.default ];

  home = {
    username = "laurent";
    homeDirectory = "/home/laurent";
    stateVersion = "24.05";
  };

}
