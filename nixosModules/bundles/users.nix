{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  ...
}:  {
	programs.zsh.enable = true;

	users.users.laurent = {
	  isNormalUser  = true;
	  home  = "/home/laurent";
	  extraGroups  = [ "wheel" "networkmanager" "docker" ];
	  shell = pkgs.zsh;
	};

}
