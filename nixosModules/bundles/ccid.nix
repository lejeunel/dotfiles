{ config, lib, pkgs, ... }:

{

  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    web-eid-app
    p11-kit
    opensc
    qdigidoc
    eid-mw
  ];

  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';

}
