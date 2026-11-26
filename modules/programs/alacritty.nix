{
  flake.modules.homeManager.alacritty =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nerd-fonts.iosevka
      ];
      programs.alacritty = {
        enable = true;
        theme = "modus_vivendi";
        settings = {
          terminal = {
            osc52 = "CopyPaste";
          };
          font = {
            normal = {
              family = "Iosevka Nerd Font";
              style = "Regular";
            };
            bold = {
              family = "Iosevka Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "Iosevka Nerd Font";
              style = "Italic";
            };
            bold_italic = {
              family = "Iosevka Nerd Font";
              style = "Bold Italic";
            };
            size = 18;
          };
          window.padding = {
            x = 10;
            y = 10;
          };
          keyboard.bindings = [
            {
              key = "[";
              mods = "Control";
              action = "ToggleViMode";
            }
            { key = "y";      mods = "Control"; action = "ReceiveChar"; }
            { key = "Equals"; mods = "Control"; action = "ReceiveChar"; }
          ];

          env.TERM = "alacritty-direct";
        };
      };
    };

}
