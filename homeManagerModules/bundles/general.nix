{ pkgs, config, lib, inputs, ... }: {

  myHomeManager.stylix.enable = lib.mkDefault true;
  myHomeManager.keyboard-layout.enable = lib.mkDefault true;

}
