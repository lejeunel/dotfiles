BASE_CMD_HOME_MANAGER = home-manager -v --show-trace --extra-experimental-features "nix-command flakes" switch --flake
home-manager:
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

home-ptw11:
	$(BASE_CMD_HOME_MANAGER) .#"laurent@ptw11"

home-barbatruc:
	$(BASE_CMD_HOME_MANAGER) .#"laurent@barbatruc"
