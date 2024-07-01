{ config, lib, pkgs, dotfilesPath, ... }:
let
  cfg = config.editors;
in
{

  home.file.".config/doom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/editors/doom";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesPath}/editors/nvim";

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
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
