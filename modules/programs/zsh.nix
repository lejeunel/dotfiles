{
  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    {
      zsh = {
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
        initContent = ''
          bindkey '^Y' autosuggest-accept
          bindkey -s ^f "tmux-sessionizer^M"

          export EDITOR="emacsclient -nw"

          # This fixes a bug where a % sign is printed in vterm
          unsetopt PROMPT_SP
        '';

        oh-my-zsh = {
          enable = true;
          plugins = [
            "command-not-found"
            "git"
            "vi-mode"
          ];
        };

      };

    };

}
