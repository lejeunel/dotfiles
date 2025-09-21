{
  config,
  ...
}:

{
  sops.secrets.wifi = { };
  networking.wireless = {
    secretsFile = config.sops.secrets."wifi".path;
    networks = {
      freebox-363c77.psk = "ext:freebox-363c77";
    };
  };
}
