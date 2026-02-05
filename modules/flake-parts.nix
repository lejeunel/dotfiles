{
  ...
}:

{
  imports = [
    # use external flake logic, e.g.
    # inputs.foo.flakeModules.default
  ];
  systems = [
    # systems for which you want to build the `perSystem` attributes
    "x86_64-linux"
    # ...
  ];
  perSystem =
    { config, pkgs, ... }:
    {
      # Recommended: move all package definitions here.
      # e.g. (assuming you have a nixpkgs input)
      # packages.foo = pkgs.callPackage ./foo/package.nix { };
      # packages.bar = pkgs.callPackage ./bar/package.nix {
      #   foo = config.packages.foo;
      # };
    };

}
