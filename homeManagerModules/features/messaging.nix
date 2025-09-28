{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    telegram-desktop
    whatsapp-for-linux
    teams-for-linux
  ];

}
