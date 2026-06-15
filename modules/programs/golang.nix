{
  flake.modules.homeManager.golang =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        go
        godef
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
