{ config, lib, pkgs, ... }:

{

  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    terminal = "alacritty-direct";
    prefix = "C-A";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
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

      bind-key -n 'C-h' 'select-pane -L'
      bind-key -n 'C-l' 'select-pane -R'

    '';
  };
}
