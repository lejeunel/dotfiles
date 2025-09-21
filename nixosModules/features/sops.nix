{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/laurent/.config/sops/age/keys.txt";

}
