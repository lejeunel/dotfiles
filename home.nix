{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
	    hello

	];

	username = "laurent";
	homeDirectory = "/home/laurent";

	stateVersion = "23.11";
    };
}
