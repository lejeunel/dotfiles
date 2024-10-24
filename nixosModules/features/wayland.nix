{ config, lib, pkgs, ... }:
let tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  security.polkit.enable = true;
  security.pam.services.swaylock = { };

  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --cmd sway";
        user = "greeter";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
    zsh
  '';

  # for touchpad
  services.libinput = {
    enable = true;
    mouse.disableWhileTyping = true;
  }

}
