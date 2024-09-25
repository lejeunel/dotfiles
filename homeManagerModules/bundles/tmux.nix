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
      set-option -g status-right ' #{prefix_highlight} "#{=21:pane_title}" %H:%M %d-%b-%y'
      set-option -g status-left-length 20
      set-option -g @prefix_highlight_fg '${config.lib.stylix.colors.base00}'
      set-option -g @prefix_highlight_bg '${config.lib.stylix.colors.base0D}'

      # Vim style pane selection
      bind h select-pane -L
      bind l select-pane -R

      bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind-key -n 'C-h' 'select-pane -L'
      bind-key -n 'C-l' 'select-pane -R'

    '';
  };
}
