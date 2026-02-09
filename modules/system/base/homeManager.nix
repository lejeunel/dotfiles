{
  flake.modules.homeManager.system-base =
    { config, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home = {
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "24.05";
      };
    };

}
