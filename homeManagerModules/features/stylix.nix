{ pkgs, inputs, lib, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix.autoEnable = true;
}
