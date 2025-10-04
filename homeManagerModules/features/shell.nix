{
  pkgs,
  ...
}:
{
  programs = {
    bat.enable = true;
    eza.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        nix_shell.symbol = " ";
      };
    };

    command-not-found = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza --color=always --long --git --icons=always";
        ll = "ls -lah";
        cd = "z"; # use zoxide
        cat = "${pkgs.bat}/bin/bat";
        tmux = "tmux -u";
        e = "emacsclient -nc";
        ee = "emacsclient -nw";
        tree = "${pkgs.eza}/bin/eza --color=auto --tree";
        cal = "cal -m";
        vim = "nvim";
        grep = "grep --color=auto";
      };
      initContent = ''
        bindkey "^K" up-line-or-search
        bindkey "^J" down-line-or-search
        bindkey '^Y' autosuggest-accept
        bindkey -s '^O' 'yy^M'
        bindkey -s ^f "tmux-sessionizer^M"

        export EDITOR="emacsclient -nw"

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
