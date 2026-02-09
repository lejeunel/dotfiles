{ ... }:

{
  flake.modules.nixos.system-base = {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

  };

}
