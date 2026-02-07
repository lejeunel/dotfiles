{ ... }:
{
  flake.modules.homeManager.tmux =
    { config, pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        sensibleOnTop = true;
        terminal = "alacritty-direct";
        prefix = "C-a";
        mouse = true;
        baseIndex = 1;
        escapeTime = 0;
        keyMode = "vi";
        historyLimit = 5000;

        plugins = with pkgs; [
          tmuxPlugins.sensible
          tmuxPlugins.dotbar
          tmuxPlugins.vim-tmux-navigator
        ];

        extraConfig = ''

          # Vim style pane selection
          bind h select-pane -L
          bind l select-pane -R

          bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

          bind-key R run-shell ' \
          tmux source-file ~/.config/tmux/tmux.conf > /dev/null; \
          tmux display-message "sourced tmux config"'

          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          bind-key -n C-h if -F "#{pane_at_left}" "" "select-pane -L"
          bind-key -n C-l if -F "#{pane_at_right}" "" "select-pane -R"

          bind-key -n C-Space resize-pane -Z

          set-option -g pane-active-border-style fg=blue

          set -ga terminal-overrides ",*256col*:Tc"
          set -g default-terminal "tmux-256color"
          set -g status on
        '';
      };
      home.sessionPath = [
        "${config.home.homeDirectory}/.local/scripts"
      ];
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

    };

}
