{

  flake.modules.homeManager.messaging =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        telegram-desktop
        karere
        teams-for-linux
        slack
      ];

    };

}
