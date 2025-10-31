{
  config,
  lib,
  pkgs,
  ...
}:
let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in
{
  security.polkit.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --cmd hyprland";
        user = "greeter";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland
    zsh
  '';

  # for touchpad
  services.libinput = {
    enable = true;
    mouse.disableWhileTyping = true;
  };

}
