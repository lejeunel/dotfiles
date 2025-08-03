{ config, lib, pkgs, ... }: {
  home.file.".config/doom".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/doom";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/nvim";

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
    "${config.home.homeDirectory}/.local/share/nvim/mason/bin"
    "${config.home.homeDirectory}/.local/scripts"
  ];

  home.packages = with pkgs; [
    # (pkgs.callPackage ./doom.nix { })
    tectonic

    # alternative to find util
    fd

    # format docker file
    dockfmt

    # compile/format C/C++
    libclang
    glslang

    # format xml files
    libxml2

    # markdown compiler
    discount

    # Tool to access the X clipboard from a console application
    xclip

    # generate graph visualization from org-mode
    graphviz

    # format/lint shell scripts
    shfmt
    shellcheck

    # format nix files
    nil # LSP
    nixfmt # formatting

    lazygit
    emacsPackages.all-the-icons-nerd-fonts

    vimgolf

  ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
  };

  systemd.user.services.emacs = {
    Unit = { Description = "Emacs Text Editor Daemon"; };
    Service = {
      Environment =
        "PATH=/usr/bin:/usr/local/bin:${config.home.homeDirectory}/.nix-profile/bin:/run/current-system/sw/bin";
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = ''${pkgs.emacs}/bin/emacsclient --eval "(kill-emacs)"'';
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

}
