{
  pkgs,
  ...
}:

{

  flake.modules.homeManager.latex =
    { pkgs, ... }:
    {
      home.packages =
        with pkgs;
        let

          tex = (
            pkgs.texliveBasic.withPackages (
              ps: with ps; [
                wrapfig
                amsmath
                ulem
                hyperref
                capt-of
                cm
                collection-fontsrecommended
              ]
            )
          );
        in
        [ tex ];

    };
}
