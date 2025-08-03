{ config, ... }:
{
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      control-center-margin-top = 22;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      notification-icon-size = 64;
      notification-body-image-height = 128;
      notification-body-image-width = 200;
      timeout = 6;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 400;
      control-center-height = 915;
      notification-window-width = 375;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "title"
        "menubar#desktop"
        "notifications"
      ];
      notification-visibility = {
        spotify = {
          state = "enabled";
          urgency = "Low";
          app-name = "Spotify";
        };
      };
    };
    style = ''
      @define-color shadow rgba(0, 0, 0, 0.25);

      @define-color base   #${config.lib.stylix.colors.base00};
      @define-color mantle #${config.lib.stylix.colors.base01};
      @define-color crust  #${config.lib.stylix.colors.base02};

      @define-color text     #${config.lib.stylix.colors.base05};
      @define-color subtext0 #${config.lib.stylix.colors.base04};
      @define-color subtext1 #${config.lib.stylix.colors.base06};

      @define-color surface0 #${config.lib.stylix.colors.base03};
      @define-color surface1 #${config.lib.stylix.colors.base04};
      @define-color surface2 #${config.lib.stylix.colors.base05};

      @define-color overlay0 #${config.lib.stylix.colors.base07};
      @define-color overlay1 #${config.lib.stylix.colors.base08};
      @define-color overlay2 #${config.lib.stylix.colors.base09};

      @define-color blue      #${config.lib.stylix.colors.base0D};
      @define-color lavender  #${config.lib.stylix.colors.base0E};
      @define-color sapphire  #${config.lib.stylix.colors.base0C};
      @define-color sky       #${config.lib.stylix.colors.base0B};
      @define-color teal      #${config.lib.stylix.colors.base0A};
      @define-color green     #${config.lib.stylix.colors.base0B};
      @define-color yellow    #${config.lib.stylix.colors.base0A};
      @define-color peach     #${config.lib.stylix.colors.base08};
      @define-color maroon    #${config.lib.stylix.colors.base08};
      @define-color red       #${config.lib.stylix.colors.base08};
      @define-color mauve     #${config.lib.stylix.colors.base0E};
      @define-color pink      #${config.lib.stylix.colors.base0F};
      @define-color flamingo  #${config.lib.stylix.colors.base07};
      @define-color rosewater #${config.lib.stylix.colors.base06};

      @define-color base_lighter  #1e1e2e;
      @define-color mauve_lighter #caa6f7;

      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        background-clip: border-box;
      }

      label {
        color: @text;
      }

      .notification {
        box-shadow: none;
        border-radius: 4px;
        background: @base;
      }

      .notification button {
        background: transparent;
        border-radius: 0px;
        border: none;
        margin: 0px;
        padding: 0px;
      }

      .notification button:hover {
        /* background: @surface0; */
        background: @insensitive_bg_color;
      }

      .notification-content {
        min-height: 64px;
        margin: 10px;
        padding: 0px;
        border-radius: 0px;
      }

      .notification-icon {
        display: none;
      }

      .close-button {
        background: transparent;
        color: transparent;
      }

      .notification-default-action,
      .notification-action {
        background: transparent;
        border: none;
      }


      .notification-default-action {
        border-radius: 4px;
      }

      /* When alternative actions are visible */
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
      }

      .notification-action {
        border-radius: 0px;
        padding: 2px;
        color: @text;
        /* color: @theme_text_color; */
      }

      /* add bottom border radius to eliminate clipping */
      .notification-action:first-child {
        border-bottom-left-radius: 4px;
      }

      .notification-action:last-child {
        border-bottom-right-radius: 4px;
      }

      /*** Notification ***/
      /* Notification header */
      .summary {
        color: @text;
        /* color: @theme_text_color; */
        font-size: 14px;
        padding: 0px;
      }

      .time {
        color: @subtext0;
        /* color: alpha(@theme_text_color, 0.9); */
        font-size: 12px;
        text-shadow: none;
        margin: 0px 0px 0px 0px;
        padding: 2px 0px;
      }

      .body {
        font-size: 14px;
        font-weight: 500;
        color: @subtext1;
        /* color: alpha(@text, 0.9); */
        /* color: alpha(@theme_text_color, 0.9); */
        text-shadow: none;
        margin: 0px 0px 0px 0px;
      }

      .body-image {
        border-radius: 4px;
      }

      /* The "Notifications" and "Do Not Disturb" text widget */
      .top-action-title {
        color: @text;
        text-shadow: none;
      }

      /* Control center */

      .control-center {
        background: @base;
      	border-radius: 10px;
        border: 2px solid @red;
        margin: 10px;
        padding: 4px;
      }

      .control-center-list {
        /* background: @base; */
        background: alpha(@crust, .80);
        min-height: 5px;
        /* border: 1px solid @surface1; */
        border-top: none;
        border-radius: 0px 0px 4px 4px;
      }

      .control-center-list-placeholder,
      .notification-group-icon,
      .notification-group {
        /* opacity: 1.0; */
        /* opacity: 0; */
        color: alpha(@theme_text_color, 0.50);
      }
      .control-center-list-placeholder image {
          opacity: 0;
          width: 0;
      }

      .notification-group {
        /* unset the annoying focus thingie */
        opacity: 1.0;
        box-shadow: none;
        /* selectable: no; */
      }

      .notification-group > box {
        all: unset;
        background: transparent;
        /* background: alpha(currentColor, 0.072); */
        padding: 4px;
        margin: 0px;
        /* margin: 0px -5px; */
        border: none;
        border-radius: 4px;
        box-shadow: none;
      }

      .notification-row {
        outline: none;
        transition: all 1s ease;
        background: alpha(@mantle, .80);
        /* background: @theme_bg_color; */
        border: 0px solid @crust;
        margin: 10px 5px 0px 5px;
        border-radius: 14px;
        /* box-shadow: 0px 0px 4px black; */
        /* background: alpha(currentColor, 0.05); */
      }

      .notification-row:focus,
      .notification-row:hover {
        box-shadow: none;
      }

      .control-center-list > row,
      .control-center-list > row:focus,
      .control-center-list > row:hover {
        background: transparent;
        border: none;
        margin: 0px;
        padding: 5px 10px 5px 10px;
        box-shadow: none;
      }

      /* Window behind control center and on all other monitors */
      .blank-window {
        background: transparent;
      }

      /*** Widgets ***/

      /* Title widget */
      .widget-title {
        margin: 0px;
        background: transparent;
        border-radius: 4px 4px 0px 0px;
        border-bottom: none;
      }

      .widget-title > label {
        margin: 18px 10px;
        font-size: 20px;
        font-weight: 500;
      }

      .widget-title > button {
        font-weight: 700;
        padding: 7px 3px;
        margin-right: 10px;
        background: transparent;
        color: @text;
        /* color: @theme_text_color; */
        border: none;
        border-radius: 4px;
      }
      .widget-title > button:hover {
        background: @base;
        /* background: alpha(currentColor, 0.1); */
      }

      /* Label widget */
      .widget-label {
        margin: 0px;
        padding: 0px;
        min-height: 5px;
        background: alpha(@mantle, .80);
        /* background: @theme_bg_color; */
        border-radius: 0px 0px 4px 4px;
        /* border: 1px solid @surface1; */
        border-top: none;
      }
      .widget-label > label {
        font-size: 15px;
        font-weight: 400;
      }

      .widget-menubar > box > revealer > box {
        margin: 5px 10px 5px 10px;
        background: alpha(@mantle, .80);
        /* background: alpha(currentColor, 0.05); */
        border-radius: 4px;
      }
      .widget-menubar > box > revealer > box > button {
        background: transparent;
        min-height: 50px;
        padding: 0px;
        margin: 5px;
      }

      .notification-group > box.vertical {
        /* border: solid 5px red; */
        margin-top: 3px;
      }

      /* Toggles */
      .toggle:checked {
        background: @surface1;
        /* background: @theme_selected_bg_color; */
      }
      /*.toggle:not(:checked) {
        color: rgba(128, 128, 128, 0.5);
      }*/
      .toggle:checked:hover {
        background: @surface2;
        /* background: alpha(@theme_selected_bg_color, 0.75); */
      }

      /* Sliders */
      scale {
        padding: 0px;
        margin: 0px 10px 0px 10px;
      }

      scale trough {
        border-radius: 4px;
        background: @surface0;
        /* background: alpha(currentColor, 0.1); */
      }

      scale highlight {
        border-radius: 5px;
        min-height: 10px;
        margin-right: -5px;
      }

      scale slider {
        margin: -10px;
        min-width: 10px;
        min-height: 10px;
        background: transparent;
        box-shadow: none;
        padding: 0px;
      }
      scale slider:hover {
      }

      .right.overlay-indicator {
        all: unset;
      }
    '';
  };
}
