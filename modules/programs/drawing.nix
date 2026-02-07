{
  ...
}:
{

  flake.modules.homeManager.drawing =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        inkscape
        gimp
      ];

    };

}
