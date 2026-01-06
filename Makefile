BASE_CMD_HOME_MANAGER = home-manager -v --show-trace --extra-experimental-features "nix-command flakes" switch --flake
home-manager:
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install

home-quantiq-vm:
	$(BASE_CMD_HOME_MANAGER) .#"laurent@quantiq-vm"

home-barbatruc:
	$(BASE_CMD_HOME_MANAGER) .#"laurent@barbatruc"
