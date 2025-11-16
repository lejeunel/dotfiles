{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    telegram-desktop
    wasistlos
    teams-for-linux
    slacky
  ];

}
