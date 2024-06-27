.PHONY: update

home-manager:
	@nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	@nix-channel --update
	@nix-shell '<home-manager>' -A install

switch: home-manager doom
	home-manager switch --flake .#laurent

doom:
	./editors/doom/maybe-install.sh

clean:
	nix-collect-garbage --delete-old

