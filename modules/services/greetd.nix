{
  flake.modules.nixos.greetd =
    { pkgs, ... }:
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
        niri
        hyprland
        zsh
      '';

      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";

        # prevent systemd from printing stuff on tty
        # which completely breaks the TUI
        StandardOutput = "null";

        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };

    };

}
