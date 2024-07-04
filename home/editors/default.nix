{ config, lib, pkgs, dotfilesPath, ... }:
let
  cfg = config.editors;
in
{

  home.file.".config/doom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/home/editors/doom";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/home/editors/nvim";

  home.packages = [
      pkgs.tectonic
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
    };
  };


  systemd.user.services.emacs = {
    Unit = {
      Description = "Emacs Text Editor Daemon";
    };
    Service = {
      Environment = "PATH=/usr/bin:/usr/local/bin:${config.home.homeDirectory}/.nix-profile/bin";
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    environment = {
      # "${pkgs.python312Packages.python-lsp-server}"
      PATH = "test";
           };
  };

}
