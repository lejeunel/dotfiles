{
  config,
  pkgs,
  ...
}:

{
  home.file.".config/doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/doom";

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
    "${config.home.homeDirectory}/.local/scripts"
  ];

  home.packages = with pkgs; [
    # (pkgs.callPackage ./doom.nix { })
    tectonic

    # alternative to find util
    fd

    # format docker file
    dockfmt

    # format xml files
    libxml2

    # markdown
    discount # compiler
    markdownlint-cli # linter

    # Tool to access the X clipboard from a console application
    xclip

    # generate graph visualization from org-mode
    graphviz

    # format/lint shell scripts
    shfmt
    shellcheck

    nil # LSP
    nixd # another lSP
    nixfmt # formatting

    emacs.pkgs.all-the-icons-nerd-fonts

    # show file types
    file

    # generic spelling and checking
    proselint
    aspell
    aspellDicts.fr
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    emacs-pgtk.pkgs.vterm

    # latex equation preview
    texliveMedium
  ];

  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
  };

  home.file.".local/scripts/emacs-tangle" = {

    executable = true;
    text = ''
      ${pkgs.emacs-pgtk}/bin/emacs --batch \
          -l org \
          --eval "(setq org-src-preserve-indentation t)" \
          "$1" \
          -f org-babel-tangle
    '';
  };

  home.file.".local/scripts/emacs-install" = {

    executable = true;
    text = ''
      EMACSDIR=$HOME/.config/emacs
      echo ">>> Deleting packages, grammars and native compilation cache ..."
      rm -rf $EMACSDIR/eln-cache $EMACSDIR/elpa $EMACSDIR/tree-sitter $EMACSDIR/elpaca $EMACSDIR/auto-save-list $EMACSDIR/transient
      echo ">>> Tangling literate config ..."
      ./$HOME/.local/scripts/emacs-tangle $EMACSDIR/config.org
      echo ">>> Starting Emacs and auto-package fetching/installing ..."
      ${pkgs.emacs-pgtk}/bin/emacs --init-dir="$EMACSDIR" -nw --eval="(ll/first-install)"
    '';
  };

  home.sessionVariables = {
    GDK_BACKEND = "wayland";
  };

  systemd.user.services.emacs = {
    Unit = {
      Description = "Emacs Text Editor Daemon";
    };
    Service = {
      Environment = [
        "PATH=/usr/bin:/usr/local/bin:${config.home.homeDirectory}/.nix-profile/bin:/run/current-system/sw/bin"
        "GDK_BACKEND=wayland"

        "TERM=xterm-256color"
        "COLORTERM=truecolor"

        # allows xdg-open from daemon
        "XDG_SESSION_TYPE=wayland"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
        "XDG_RUNTIME_DIR=%t"
      ];
      Type = "forking";
      ExecStart = "${pkgs.emacs-pgtk}/bin/emacs --daemon";
      ExecStop = ''${pkgs.emacs-pgtk}/bin/emacsclient --eval "(kill-emacs)"'';
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  xdg.desktopEntries = {
    emacsclient = {
      name = "Emacs Client";
      genericName = "Text Editor";
      exec = "${pkgs.emacs-pgtk}/bin/emacsclient -nc %f";
      icon = "emacs";
    };
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "emacsclient.desktop" ];
      "text/x-script.python" = [ "emacsclient.desktop" ];
      "text/x-tex" = [ "emacsclient.desktop" ];
    };
  };

}
