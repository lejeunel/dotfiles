{ inputs, pkgs, lib, config, ... }:
let lf = "${pkgs.lf}/bin/lf";
in {

  myHomeManager.lf.enable = true;
  home.packages = with pkgs; [ calcurse bluetuith htop neofetch nh psmisc ];

  programs = {

    git = {
      enable = true;
      userEmail = "me@lejeunel.org";
      userName = "lejeunel";
      aliases = {
        co = "checkout";
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

        layout_poetry() {
          if [[ ! -f pyproject.toml ]]; then
            log_error 'No pyproject.toml found.  Use `poetry new` or `poetry init` to create one first.'
            exit 2
          fi

          local VENV=$(dirname $(poetry run which python))
          export VIRTUAL_ENV=$(echo "$VENV" | rev | cut -d'/' -f2- | rev)
          export POETRY_ACTIVE=1
          PATH_add "$VENV"
        }

      '';
    };

    eza = { enable = true; };

    bat = { enable = true; };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = { enable = true; };
      shellAliases = {
        ls = "eza --color=always --long --git --icons=always";
        ll = "ls -lah";
        cat = "bat";
        tmux = "tmux -u";
        e = "emacsclient -nc";
        tree = "${pkgs.eza}/bin/eza --color=auto --tree";
        cal = "cal -m";
        grep = "grep --color=auto";
      };
      initExtra = ''
        bindkey "^K" up-line-or-search
        bindkey "^J" down-line-or-search
        bindkey '^ ' autosuggest-accept
        bindkey -s '^O' 'lf^M'
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "command-not-found" "git" "vi-mode" ];
      };

    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    command-not-found = { enable = true; };

    ripgrep = { enable = true; };

  };

}
