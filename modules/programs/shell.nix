{ inputs, ... }:
{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        zsh
      ];

      home.packages = with pkgs; [
        calcurse
        fastfetch
        psmisc
        nh
        pdftk
        imagemagick
        unzip
        lazydocker
        stow
        rsync
        parallel
        wget
      ];

      programs = {
        bat.enable = true;
        eza.enable = true;
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
        };

        starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            nix_shell.symbol = " ";
          };
        };

        command-not-found = {
          enable = true;
        };

        btop = {
          enable = true;
        };

        ripgrep = {
          enable = true;
        };

      };

    };

}
