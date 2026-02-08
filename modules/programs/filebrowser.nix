{
  flake.modules.homeManager.filebrowser =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        filebrowser
      ];

    };

}
