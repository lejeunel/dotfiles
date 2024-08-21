.PHONY: update

home-manager-install:
	@nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	@nix-channel --update
	@nix-shell '<home-manager>' -A install

rebuild:
	sudo nixos-rebuild switch --flake .#$(HOSTNAME)

home: home-manager-install
	home-manager switch --flake .#laurent

doom:
	./homeManagerModules/editors/doom/maybe-install.sh

clean:
	nix-collect-garbage --delete-old

