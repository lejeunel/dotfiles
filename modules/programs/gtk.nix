{ ... }:
{

  flake.modules.homeManager.gtk =
    { pkgs, ... }:
    {
      gtk.enable = true;
      gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
      gtk.iconTheme.name = "GruvboxPlus";

    };
}
