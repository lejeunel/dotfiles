{ ... }:

{

  flake.modules.homeManager.lua =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        luaformatter
        lua-language-server
      ];

    };
}
