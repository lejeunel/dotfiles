{ config, lib, pkgs, ... }:

let

  font = "JetBrainsMono Nerd Font";
in {

  programs.rofi = {
    enable = true;
    font = "${font}" + " 12";
    theme = "./theme.rasi";
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Oranchelo";
      show-icons = true;
      hide-scrollbar = "true";

      drun-display-format = "{icon} {name}";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
      disable-history = false;

      kb-remove-to-eol = "Control+Shift+e";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "";
      kb-accept-entry = "Return";
      kb-row-up = "Up,Control+k";
      kb-row-down = "Down,Control+j";
      kb-mode-next = "Control+l";
      kb-mode-previous = "Control+h";

    };
  };

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
        bg-col:  #${config.colorScheme.palette.base02};
        bg-col-light: #${config.colorScheme.palette.base03};
        border-col: #${config.colorScheme.palette.base08};
        selected-col: #${config.colorScheme.palette.base0D};
        blue: #${config.colorScheme.palette.base0D};
        fg-col: #${config.colorScheme.palette.base05};
        fg-col2: #${config.colorScheme.palette.base04};
        grey: #${config.colorScheme.palette.base04};

        width: 600;
        font: "${font} 14";
    }

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        height: 460px;
        border: 3px;
        border-color: @border-col;
        background-color: @bg-col;
        border:           4;
        padding:          5;
    }

    mainbox {
        background-color: @bg-col;
    }

    inputbar {
        children: [prompt,entry];
        background-color: @bg-col;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @blue;
        padding: 6px;
        text-color: @bg-col;
        border-radius: 3px;
        margin: 20px 0px 0px 20px;
    }

    textbox-prompt-colon {
        expand: false;
        str: ":";
    }

    entry {
        padding: 6px;
        margin: 20px 0px 0px 10px;
        text-color: @fg-col;
        background-color: @bg-col;
    }

    listview {
        border: 0px 0px 0px;
        padding: 6px 0px 0px;
        margin: 10px 0px 0px 20px;
        columns: 1;
        lines: 5;
        background-color: @bg-col;
    }

    element {
        padding: 5px;
        background-color: @bg-col;
        text-color: @fg-col  ;
    }

    element-icon {
        size: 25px;
    }

    element selected {
        background-color:  @selected-col ;
        text-color: @fg-col2  ;
    }

    mode-switcher {
        spacing: 0;
      }

    button {
        padding: 10px;
        background-color: @bg-col-light;
        text-color: @grey;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color: @bg-col;
      text-color: @blue;
    }

    message {
        background-color: @bg-col-light;
        margin: 2px;
        padding: 2px;
        border-radius: 5px;
    }

    textbox {
        padding: 6px;
        margin: 20px 0px 0px 20px;
        text-color: @blue;
        background-color: @bg-col-light;
    }

  '';

}
