{ inputs, ... }:

{
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-base

      users
      console
      locale
      fonts
      systemd-boot
      networking
      stylix
      upower
      greetd
    ];

  };

}
