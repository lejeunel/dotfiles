{ inputs, pkgs, lib, config, gitIdentity, homeDirectory, ...}:
let
  lf = "${pkgs.lf}/bin/lf";
in {

  imports = [./lf];

  programs = {

    git = {
      enable = true;
      userEmail = "${gitIdentity.email}";
      userName = "${gitIdentity.username}";
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

    eza = {
      enable = true;
    };

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

    pyenv = {
      enable = true;
      enableZshIntegration = true;
      rootDirectory = "${homeDirectory}/.pyenv";
    };

  };

}
