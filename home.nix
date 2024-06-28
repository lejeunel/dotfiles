{ lib, pkgs, config, homeDirectory, username, ... }:


{
  home = {

    homeDirectory = "${homeDirectory}";
    stateVersion = "24.05";
    username = "${username}";

  };

  imports = [
    ./shell
    ./editors
    ./desktop
  ];

}
