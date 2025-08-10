{
  ...
}:
{
  programs.afew = {
    enable = true;
    extraConfig = ''
      [SpamFilter]
      [KillThreadsFilter]
      [ListMailsFilter]
      [FolderNameFilter]
      [HeaderMatchingFilter.1]
      header = X-Maildir
      pattern = .*
      tags = -new
      query = tag:new
    '';
  };
}
