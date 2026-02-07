{
  ...
}:
{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        lazygit
      ];

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

    };

}
