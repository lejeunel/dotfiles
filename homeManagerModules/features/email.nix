{
  pkgs,
  config,
  ...
}:

let
  name = "Laurent Lejeune";
  maildir = ".mail";
in
{
  imports = [ ./afew.nix ];
  accounts.email = {
    maildirBasePath = "${maildir}";
    accounts = {
      Gmail = {
        address = "olol85@gmail.com";
        userName = "olol85@gmail.com";
        flavor = "gmail.com";
        passwordCommand = "${pkgs.pass}/bin/pass gmail";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [
            "INBOX"
            "Sent"
            "Drafts"
            "Trash"
            "Junk"
            "Unwanted"
            "Spam"
          ];
        };
        realName = "${name}";
        msmtp.enable = true;
        notmuch.enable = true;
      };
      Gandi = {
        address = "me@lejeunel.org";
        userName = "me@lejeunel.org";
        flavor = "plain";
        passwordCommand = "${pkgs.pass}/bin/pass gandi";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        imap = {
          host = "mail.gandi.net";
          port = 993;
          tls.enable = true;
        };
        realName = "${name}";
        msmtp.enable = true;
        smtp = {
          host = "mail.gandi.net";
          port = 587;
          tls.useStartTls = true;
        };
        notmuch.enable = true;
      };
    };
  };

  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
      new = {
        ignore = [
          "trash"
          "*.json"
        ];
        tags = [ "new" ];
      };
      search.excludeTags = [
        "trash"
        "deleted"
        "spam"
      ];
      maildir.synchronizeFlags = true;
    };
  };
  services = {
    mbsync = {
      enable = true;
      frequency = "*:0/5";
      preExec = "${pkgs.notmuch}/bin/notmuch new";
      postExec = "${pkgs.afew}/bin/afew -C ${config.home.homeDirectory}/.config/notmuch/default/config --tag --new";
    };
  };

}
