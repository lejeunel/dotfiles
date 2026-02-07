{ ... }:

{
  flake.modules.homeManager.golang =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        go
        gopls
        gotools
        gomodifytags
        gocode-gomod
        gotestsum
        gotest
        gofumpt
      ];
    };

}
