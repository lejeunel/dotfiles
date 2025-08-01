{ config, lib, pkgs, ... }:
let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  terminalFileManager = "${pkgs.yazi}/bin/yazzi";
  browser = "${pkgs.firefox}/bin/firefox";
  clipboard = "${pkgs.wl-clipboard-rs}/bin/wl-paste";
  hyprsunset = "${pkgs.hyprsunset}/bin/hyprsunset";
  notif-center = "${pkgs.swaynotificationcenter}/bin/swaync-client -t";
  scriptsPath = ".config/hypr/scripts";
  scriptsFPath = "${config.home.homeDirectory}/${scriptsPath}";
  calendar = "${pkgs.calcurse}/bin/calcurse";
  term_float = "${terminal} --class floating_shell -e";
  editor = "${pkgs.emacs}/bin/emacsclient -nc";
in {

  xdg.configFile."hypr/scripts" = {
    source = ./scripts;
    recursive = true;
  };

  imports = [
    ./programs/waybar
    ./programs/wlogout
    ./programs/rofi
    ./programs/hypridle
    ./programs/hyprlock
    ./programs/hyprpaper
    ./programs/swaync
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "us"; # Base layout (QWERTY)
        kb_variant = "intl"; # Variant: "intl" for International (dead keys)
        natural_scroll = true;
        touchpad = { natural_scroll = true; };
      };
      monitor = [ "eDP-1,1920x1080@60.04900,0x0, 1" ];
      "$mainMod" = "SUPER";
      "$term" = "${terminal}";
      "$fileManager" =
        ''$term --class "terminalFileManager" -e ${terminalFileManager}'';
      "$browser" = "${browser}";

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "EGL_PLATFORM,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "NIXPKGS_ALLOW_UNFREE,1"
      ];
      exec-once = [
        "hyprctl setcursor ${config.stylix.cursor.name} ${
          toString config.stylix.cursor.size
        }"
        "wl-paste --watch cliphist store"
        "waybar"
        "swaync"
        "nm-applet --indicator"
        "wl-clipboard-history -t"
        "${clipboard} --type text --watch cliphist store" # clipboard store text data
        "${clipboard} --type image --watch cliphist store" # clipboard store image data
        "rm '$XDG_CACHE_HOME/cliphist/db'" # Clear clipboard
        "${scriptsFPath}/batterynotify.sh" # battery notification
        "polkit-agent-helper-1"
        "pamixer --set-volume 50"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 9;
        border_size = 2;
        # "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        # "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        resize_on_border = true;
        layout = "dwindle"; # dwindle or master
        # allow_tearing = true; # Allow tearing for games (use immediate window rules for specific games or all titles)
      };
      decoration = {
        shadow.enabled = false;
        rounding = 10;
        dim_special = 0.3;
        blur = {
          enabled = true;
          special = true;
          size = 6; # 6
          passes = 2; # 3
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
      };
      # group = {
      #   "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      #   "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      #   "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      #   "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      # };
      layerrule = [
        "blur, rofi"
        "ignorezero, rofi"
        "ignorealpha 0.7, rofi"

        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.7, swaync-control-center"
        # "ignorealpha 0.8, swaync-notification-window"
        # "dimaround, swaync-control-center"
      ];
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          # "workspaces, 1, 3.5, md3_decel, slide"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          # "workspaces, 1, 7, fluent_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
      render = {
        direct_scanout =
          2; # 0 = off, 1 = on, 2 = auto (on with content type ‘game’)
      };
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      misc = {
        disable_hyprland_logo = true;
        mouse_move_focuses_monitor = true;
        swallow_regex = "^(Alacritty|kitty)$";
        enable_swallow = true;
        vfr = true; # always keep on
        vrr = 1; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only)
      };
      xwayland.force_zero_scaling = false;
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
        new_on_top = true;
        mfact = 0.5;
      };
      windowrule = [
        "float, title:^(nmtui)$"
        "size 800 600, title:^(nmtui)$"
        "center, title:^(nmtui)$"

        "float, title:^(bluetuith)$"
        "size 800 600, title:^(bluetuith)$"
        "center, title:^(bluetuith)$"

        "float, title:^(pulsemixer)$"
        "size 800 600, title:^(pulsemixer)$"
        "center, title:^(pulsemixer)$"
      ];
      binde = [
        # Functional keybinds
        ",XF86MonBrightnessDown,exec,brightnessctl set 2%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +2%"
        ",XF86AudioLowerVolume,exec,pamixer -d 2"
        ",XF86AudioRaiseVolume,exec,pamixer -i 2"
      ];
      bind = [
        "$mainMod, Q, killactive"

        # Night Mode (lower value means warmer temp)
        "$mainMod, N, exec, ${scriptsFPath}/hyprsunset.sh"

        # Window/Session actions
        "$mainMod, SPACE, togglefloating" # toggle the window on focus to float
        "$mainMod SHIFT, G, togglegroup" # toggle the window on focus to float
        "$mainMod, F, fullscreen" # toggle the window on focus to fullscreen
        "$mainMod ALT, L, exec, hyprlock" # lock screen
        "$mainMod, backspace, exec, pkill -x wlogout || wlogout -b 4" # logout menu

        # Applications/Programs
        "$mainMod, Return, exec, $term"
        "$mainMod, E, exec, ${editor}"

        "$mainMod, D, exec, pkill -x rofi || ${scriptsFPath}/rofi.sh drun" # launch desktop applications
        "$mainMod, I, exec, pkill -x rofi || ${scriptsFPath}/rofi.sh emoji" # launch emoji picker
        "$mainMod SHIFT, N, exec, swaync-client -t -sw" # swayNC panel
        "$mainMod, V, exec, ${scriptsFPath}/ClipManager.sh" # Clipboard Manager

        # Screenshot/Screencapture
        "$mainMod, P, exec, ${scriptsFPath}/screenshot.sh s" # drag to snip an area / click on a window to print it

        # Functional keybinds
        ",xf86Sleep, exec, systemctl suspend" # Put computer into sleep mode
        ",XF86AudioMicMute,exec,pamixer --default-source -t" # mute mic
        ",XF86AudioMute,exec,pamixer -t" # mute audio
        ",XF86AudioPlay,exec,playerctl play-pause" # Play/Pause media
        ",XF86AudioPause,exec,playerctl play-pause" # Play/Pause media
        ",xf86AudioNext,exec,playerctl next" # go to next media
        ",xf86AudioPrev,exec,playerctl previous" # go to previous media

        # to switch between windows in a floating workspace
        "$mainMod, Tab, cyclenext"
        "$mainMod, Tab, bringactivetotop"

        # Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
        "$mainMod CTRL, h, workspace, r-1"
        "$mainMod CTRL, l, workspace, r+1"

        # Move focus with mainMod + HJKL keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
        "$mainMod CTRL ALT, l, movetoworkspace, r+1"
        "$mainMod CTRL ALT, h, movetoworkspace, r-1"

        # Move active window around current workspace with mainMod + SHIFT + CTRL [HLJK]
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Special workspaces (scratchpad)
        "$mainMod CTRL, S, movetoworkspacesilent, special"
        "$mainMod ALT, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace,"
      ] ++ (builtins.concatLists (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in [
          "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
          "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
        ]) 10));
      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

  };

}
