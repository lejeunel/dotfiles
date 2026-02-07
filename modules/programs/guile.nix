{
  pkgs,
  ...
}:

{
  flake.modules.homeManager.guile =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        guile
      ];

    };

}
