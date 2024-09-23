{ inputs, pkgs, lib, config, ... }:
let lf = "${pkgs.lf}/bin/lf";
in {

  myHomeManager.lf.enable = true;
  home.packages = with pkgs; [
    calcurse
    bluetuith
    htop
    neofetch
    nh
    psmisc
    pdftk
    imagemagick
  ];

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

    tmux = {
      enable = true;
      sensibleOnTop = true;
      terminal = "alacritty-direct";
      prefix = "C-Space";
      mouse = true;
      baseIndex = 1;
      keyMode = "vi";
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.vim-tmux-navigator;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
      ];
      extraConfig = ''
        # Vim style pane selection
         bind h select-pane -L
         bind l select-pane -R

        bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
    };

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
        ee = "emacsclient -nw";
        tree = "${pkgs.eza}/bin/eza --color=auto --tree";
        cal = "cal -m";
        grep = "grep --color=auto";
      };
      initExtra = ''
        bindkey "^K" up-line-or-search
        bindkey "^J" down-line-or-search
        bindkey '^A' autosuggest-accept
        bindkey -s '^O' 'lf^M'
        bindkey -s ^f "tmux-sessionizer^M"

        export EDITOR="emacsclient -nw"
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

  home.file.".local/scripts/tmux-sessionizer" = {

    executable = true;
    text = ''
      #!/usr/bin/env bash

      TMUXEXEC=${pkgs.tmux}/bin/tmux
      FZF=${pkgs.fzf}/bin/fzf
      FIND=${pkgs.findutils}/bin/find

      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$($FIND ~/code -mindepth 1 -maxdepth 1 -type d | $FZF)
      fi

      if [[ -z $selected ]]; then
          exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)
      tmux_running=$(pgrep $TMUXEXEC)

      if [[ -z $TMUXEXEC ]] && [[ -z $tmux_running ]]; then
          $TMUXEXEC new-session -s $selected_name -c $selected
          exit 0
      fi

      if ! $TMUXEXEC has-session -t=$selected_name 2> /dev/null; then
          $TMUXEXEC new-session -ds $selected_name -c $selected
      fi

      if [[ -z $TMUX ]]; then
          $TMUXEXEC attach -t $selected_name
      else
          $TMUXEXEC switch-client -t $selected_name
      fi
    '';
  };

}
