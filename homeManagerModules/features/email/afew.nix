{
  ...
}:
{
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
}
