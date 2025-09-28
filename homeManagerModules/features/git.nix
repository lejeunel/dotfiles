{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lazygit
  ];

  programs.git = {
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

}
