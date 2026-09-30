{
  flake.modules.homeManager.zsh =
    { pkgs,lib, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "eza --color=always --long --git --icons=always";
          ll = "ls -lah";
          cd = "z"; # use zoxide
          cat = "${pkgs.bat}/bin/bat";
          tmux = "tmux -u";
          ec = "emacsclient -nc";
          eec = "emacsclient -nw";
          e = "emacs -nc";
          ee = "emacs -nw";
          tree = "${pkgs.eza}/bin/eza --color=auto --tree";
          cal = "cal -m";
          vim = "nvim";
          grep = "grep --color=auto";
        };
        plugins = [          {
            name = "zsh-shift-select";
            src = pkgs.fetchFromGitHub {
              owner = "jirutka";
              repo = "zsh-shift-select";
              rev = "da460999b7d31aef0f0a82a3e749d70edf6f2ef9r";
              hash = "sha256-ekA8acUgNT/t2SjSBGJs2Oko5EB7MvVUccC6uuTI/vc=";
            };
        }];        
        initContent = ''
          bindkey '^Y' autosuggest-accept
          bindkey '^W' kill-region
          bindkey -e

          export EDITOR="emacsclient -nw"

          # This fixes a bug where a % sign is printed in vterm
          unsetopt PROMPT_SP
        '';

        oh-my-zsh = {
          enable = true;
          plugins = [
            "command-not-found"
            "git"
          ];
        };

      };

    };

}
