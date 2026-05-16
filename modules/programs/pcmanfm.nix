{
  flake.modules.homeManager.pcmanfm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pcmanfm
      ];

    };
}
