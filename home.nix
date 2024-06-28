{ lib, pkgs, config, ... }:

let
  username = "laurent";
  email = "me@lejeunel.org";
  fullname = "Laurent Lejeune";
  font = "JetBrainsMono Nerd Font";

in {
  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

  };

  imports = [./shell ./editors];



  programs = {
    pyenv = {
      enable = true;
      enableZshIntegration = true;
      rootDirectory = "/home/${username}/.pyenv";
    };

    git = {
      enable = true;
      userEmail = "${email}";
      userName = "${fullname}";
      aliases = {co = "checkout";
                br = "branch";
                ci = "commit";
                st = "status";
                unstage = "reset HEAD --";
                last = "log -1 HEAD";
                };
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
      };
    };


    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        font = "inconsolata 15";
        adjust-open = "width";
        show-scrollbars = true;
      };
      mappings = {
        "f" = "toggle_fullscreen";
        "b" = "toggle_statusbar";
        "[fullscreen] f" = "toggle_fullscreen";
        "c" = "recolor";
        "p" = "print";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        import = [ pkgs.alacritty-theme.catppuccin_macchiato ];
        font = {
          size = 13;
          normal.family = font;
        };
        window.padding = {
          x = 10;
          y = 10;
        };
        env.term = "xterm-256color";

      };
    };

  };

}
