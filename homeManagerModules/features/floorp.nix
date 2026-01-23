{
  inputs,
  ...
}:

{

  programs.floorp = {
    enable = true;
    profiles = {
      laurent = {
        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          ublock-origin
          sponsorblock
          darkreader
          vimium
          multi-account-containers
          youtube-shorts-block
        ];

      };
    };
  };
}
