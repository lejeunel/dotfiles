{ pkgs, config, lib, inputs, ... }: {
  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  programs.home-manager.enable = true;
  myHomeManager.stylix.enable = lib.mkDefault true;
}

