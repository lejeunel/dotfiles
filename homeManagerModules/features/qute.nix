{
  ...
}:

{

  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://www.google.com/search?hl=eng&q={}";
      g = "https://www.google.com/search?hl=eng&q={}";
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      h = "https://home-manager-options.extranix.com/?query={}";
      n = "https://mynixos.com/search?q={}";
    };
    settings = {
      scrolling.smooth = true;
    };
    keyBindings = {
      normal = {
        "Shift+J" = "tab-prev";
        "Shift+K" = "tab-next";
      };
    };
  };
}
