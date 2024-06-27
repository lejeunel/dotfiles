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

  home.file.".config/nvim" = {
    source =  ./nvim;

  };

  home.file.".config/doom.d" = {
    source =  ./doom.d;

  };

  programs = {
    bat = {
      enable = true;
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            sha256 = "Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
          };
          file = "themes/Catppuccin Macchiato.tmTheme";
        };
      };
      config = {
        theme = "catppuccin";
      };
    };
    eza = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      stdlib = ''
        use_python() {
            if has pyenv; then
                local pyversion=$1
                eval "$(pyenv init --path)"
                eval "$(pyenv init -)"
                pyenv local ''${pyversion} || log_error "Could not find pyenv version ''${pyversion}. Consider running 'pyenv install ''${pyversion}'"
            fi
        }

        layout_activate() {
                local pyenvprefix=$(pyenv prefix)
                local pyversion=$(pyenv version-name)
                local pvenv="$1"

                pyenv activate ''${pvenv}
        }
      '';
    };
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

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      shellAliases = {
        ls = "eza --color=always --long --git --icons=always";
        ll = "ls -lah";
        cat = "bat";
        tmux = "tmux -u";
        e = "emacsclient -nc";
      };
      initExtra = ''
        bindkey "^K" up-line-or-search
        bindkey "^J" down-line-or-search
        bindkey '^ ' autosuggest-accept
        bindkey -s '^O' 'lf^M'
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [
          "command-not-found" 
          "git"
          "fzf"
          "vi-mode"
        ];
      };

    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
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

    systemd.user.services.emacs = {
      Unit = {
        Description = "Emacs Text Editor Daemon";
      };
      Service = {
        ExecStart = "/usr/bin/emacs --daemon";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

}
