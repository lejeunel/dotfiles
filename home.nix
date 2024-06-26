{ lib, pkgs, config, ... }:

let
  username = "laurent";
  email = "me@lejeunel.org";
  fullname = "Laurent Lejeune";
in {
  home = {
    packages = with pkgs; [
      hello
    ];
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

  };

  home.file.".config/nvim" = {
    source =  ./nvim;
    recursive = true;

  };

  home.file.".config/doom.d" = {
    source =  ./doom.d;
    recursive = true;

  };

  programs = {
    bat = {
      enable = true;
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
    alacritty = {
      enable = true;
      settings = {
        import = [ pkgs.alacritty-theme.catppuccin_macchiato ];
        font = {
          size = 13;
          normal.family = "JetBrainsMono Nerd Font";
        };
        window.padding = {
          x = 10;
          y = 10;
        };
        env.term = "xterm-256color";

      };
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
