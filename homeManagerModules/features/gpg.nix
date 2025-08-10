{ pkgs, ... }:

{

  home.packages = with pkgs; [
    gnupg # For password decryption
    pass
    pinentry-curses
  ];
  programs.gpg = {
    enable = true;
    settings = {
      pinentry-mode = "loopback"; # Only if automated (else remove)
    };
  };

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-loopback-pinentry
      allow-emacs-pinentry
      pinentry-program ${pkgs.pinentry-curses}/bin/pinentry
    '';
  };

}
