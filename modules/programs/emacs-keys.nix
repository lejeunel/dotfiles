{

  flake.modules.homeManager.emacs-keys =
    { ... }:
    {
      # Emacs keybindings in GTK text fields (C-a, C-e, C-k, C-w, ...).
      # On Wayland GTK3 reads gsettings, settings.ini is the fallback.
      gtk.gtk3.extraConfig.gtk-key-theme-name = "Emacs";
      dconf.settings."org/gnome/desktop/interface".gtk-key-theme = "Emacs";
    };

}
