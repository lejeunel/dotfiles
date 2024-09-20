{ config, inputs, pkgs, ... }: {

  myHomeManager.rofi.enable = true;
  myHomeManager.alacritty.enable = true;
  myHomeManager.zathura.enable = true;
  myHomeManager.imv.enable = true;
  myHomeManager.office.enable = true;
  myHomeManager.stylix.enable = true;
  myHomeManager.gtk.enable = true;

  home.packages = with pkgs; [
    thunderbird
    dconf
    nautilus
    gnome-screenshot
    gnome-calculator
    telegram-desktop
    evince
    inkscape
    gimp
    vlc
    grobi
  ];

  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "${pkgs.imv}/bin/imv -n %f .";
    };
    emacsclient = {
      name = "Emacs Client";
      genericName = "Text Editor";
      exec = "${pkgs.emacs}/bin/emacsclient -nc %f";
      icon = "emacs";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "image/jpeg" = [ "imv.desktop" ];
      "image/gif" = [ "imv.desktop" ];

      "text/plain" = [ "emacsclient.desktop" ];
      "text/x-script.python" = [ "emacsclient.desktop" ];
      "text/x-tex" = [ "emacsclient.desktop" ];

      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };

  programs.firefox = {
    enable = true;
    profiles.laurent = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        sponsorblock
        darkreader
        vimium
        multi-account-containers
        youtube-shorts-block
      ];

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@n" ];
        };
      };

      search.force = true;

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";

        # taken from Misterio77's config
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  services.grobi = {
    enable = true;
    executeAfter = [ "${pkgs.systemd}/bin/systemctl --user restart polybar" ];
    rules = [
      {
        name = "Dual";
        outputs_connected = [ "HDMI-2" "eDP-1" ];
        configure_row = [ "HDMI-2" "eDP-1" ];
        primary = "HDMI-2";
      }
      {
        name = "Mobile";
        outputs_connected = [ "eDP-1" ];
        outputs_disconnected = [ "HDMI-2" ];
        configure_single = "eDP-1";
        primary = true;
        atomic = true;
      }
    ];
  };

}
