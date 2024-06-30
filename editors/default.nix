{ config, lib, pkgs, editorsCfgPath, ... }:
let
  cfg = config.editors;

in
{

  home.file.".config/doom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${editorsCfgPath}/doom";
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${editorsCfgPath}/nvim";

  programs = {
    neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };

  };


  systemd.user.services.emacs = {
    Unit = {
      Description = "Emacs Text Editor Daemon";
    };
    Service = {
      Type = "forking";
      ExecStart = "/usr/bin/emacs --daemon";
      ExecStop = "/usr/bin/emacsclient --eval \"(kill-emacs)\"";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
