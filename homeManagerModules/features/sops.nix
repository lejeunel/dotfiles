{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    sops
    age
  ];

  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

}
