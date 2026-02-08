{
  flake.modules.homeManager.cpp =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ccls
        gnumake
        cmake
        gcc
      ];

    };

}
