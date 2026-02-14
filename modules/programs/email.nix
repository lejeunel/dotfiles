let
  name = "Laurent Lejeune";
  maildir = ".mail";
in
{

  flake.modules.homeManager.email =
    {
      pkgs,
      config,
      ...
    }:
    {
      sops.secrets."email/gandi" = { };
      sops.secrets."email/gmail" = { };
      accounts.email = {
        maildirBasePath = "${maildir}";
        accounts = {
          Gmail = {
            address = "olol85@gmail.com";
            userName = "olol85@gmail.com";
            flavor = "gmail.com";
            passwordCommand = "cat ${config.sops.secrets."email/gmail".path}";
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
            passwordCommand = "cat ${config.sops.secrets."email/gandi".path}";
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
      programs.afew = {
        enable = true;
        extraConfig = ''
          [SpamFilter]
          [SentMailsFilter]
            sent_tag=sent
          [KillThreadsFilter]
          [ListMailsFilter]
          [FolderNameFilter]
          [InboxFilter]
        '';
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
          postExec = "${config.home.homeDirectory}/.local/bin/post-sync-mailboxes";
        };
      };

      home.file.".local/bin/post-sync-mailboxes" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail  # Strict error handling
          export NOTMUCH_CONFIG=${config.home.homeDirectory}/.config/notmuch/default/config
          ${pkgs.notmuch}/bin/notmuch new

          # Process each new message and send notification
          ${pkgs.notmuch}/bin/notmuch search --output=summary tag:new | while read -r line; do
              # Extract relevant parts (adjust based on your notmuch output format)
              from=$(echo "$line" | sed -E 's/.*\] ([^;]+);.*/\1/')

              # Extract subject (everything after "; ")
              subject=$(echo "$line" | sed -E 's/.*; (.*)/\1/')

              # Clean up any trailing tags like "(new unread)"
              subject=$(echo "$subject" | sed -E 's/\([^)]*\)$//' | xargs -0)

              # Send notification
              notify-send -t 5000 "New email from $from" "$subject"
          done

          ${pkgs.afew}/bin/afew --tag --new
        '';
      };

      home.file.".mailcap".text = ''
        application/pdf; xdg-open %s
        image/*; xdg-open %s
        text/html; xdg-open %s
        application/vnd.openxmlformats-officedocument.wordprocessingml.document; xdg-open %s
      '';

    };
}
