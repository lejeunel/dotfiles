{

  flake.modules.homeManager.wifi =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        impala
      ];
    };
}
