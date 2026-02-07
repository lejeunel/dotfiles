{ inputs, ... }:

{
  flake.modules.homeManager.sops =
    { pkgs, config, ... }:
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

      # write ~/.git-credentials on home-manager switch
      # this uses sops secrets
      sops.secrets.github-pat = { };
      home.activation.gitCredentials = ''
          cat > ${config.home.homeDirectory}/.git-credentials <<EOF
        https://$(cat ${config.sops.secrets.github-pat.path})@github.com
        EOF
          chmod 600 ${config.home.homeDirectory}/.git-credentials
      '';
    };
}
