{ pkgs, ... }:

{

  home.packages = with pkgs; [
    gnupg
    pass
  ];
  programs.gpg = {
    enable = true;
  };

}
