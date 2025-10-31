{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lazygit
  ];
  # trace: warning: The option `programs.git.aliases' defined in `/nix/store/ax1aln7na5fhdwzyqcjbdcw6chkbhnml-source/homeManagerModules' has been renamed to `programs.git.settings.alias'.
  # trace: warning: The option `programs.git.userEmail' defined in `/nix/store/ax1aln7na5fhdwzyqcjbdcw6chkbhnml-source/homeManagerModules' has been renamed to `programs.git.settings.user.email'.
  # trace: warning: The option `programs.git.userName' defined in `/nix/store/ax1aln7na5fhdwzyqcjbdcw6chkbhnml-source/homeManagerModules' has been renamed to `programs.git.settings.user.name'.
  # trace: warning: The option `programs.git.extraConfig' defined in `/nix/store/ax1aln7na5fhdwzyqcjbdcw6chkbhnml-source/homeManagerModules' has been renamed to `programs.git.settings'.

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "lejeunel";
        email = "me@lejeunel.org";
      };
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
      };
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

}
