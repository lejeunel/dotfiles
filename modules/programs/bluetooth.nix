{
  pkgs,
  ...
}:

{
  flake.modules.homeManager.bluetooth =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bluetui
      ];

    };
}
