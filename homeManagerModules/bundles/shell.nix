{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    calcurse
    bluetuith
    fastfetch
    nh
    psmisc
    htop
    nh
    pdftk
    imagemagick
    unzip
    lazygit
    lazydocker
  ];

  programs = {

    yazi = {
      enable = true;
    };

    git = {
      enable = true;
      userEmail = "me@lejeunel.org";
      userName = "lejeunel";
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
      };
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
    };

    bat = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza --color=always --long --git --icons=always";
        ll = "ls -lah";
        cat = "bat";
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
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    command-not-found = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

  };
  xdg.configFile."bluetuith/bluetuith.conf".text = ''
    {
      adapter: ""
      adapter-states: ""
      connect-bdaddr: ""
      gsm-apn: ""
      gsm-number: ""
      keybindings: {
        NavigateDown: j
        NavigateUp: k
        Quit: q
      }
      receive-dir: ""
      theme: {}
    }
  '';

  sops.secrets.github-pat = { };
  home.activation.gitCredentials = ''
      cat > ${config.home.homeDirectory}/.git-credentials <<EOF
    https://$(cat ${config.sops.secrets.github-pat.path})@github.com
    EOF
      chmod 600 ${config.home.homeDirectory}/.git-credentials
  '';

}
