{
  flake.modules.homeManager.hyprlock =
    { config, ... }:
    {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
          };

          label = [
            {
              monitor = "";
              text = "$TIME";
              font_size = 64;
              font_family = "JetBrains Mono Nerd Font 10";
              color = "rgb(${config.stylix.base16Scheme.base0D})";
              position = "0, 16";
              valign = "center";
              halign = "center";
            }
            {
              monitor = "";
              text = ''Hello <span text_transform="capitalize" size="larger">$USER!</span>'';

              color = "rgb(${config.stylix.base16Scheme.base0D})";
              font_size = 20;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 100";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "";
              text = "Current Layout : $LAYOUT";
              color = "rgb(${config.stylix.base16Scheme.base0D})";
              font_size = 14;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 20";
              halign = "center";
              valign = "bottom";
            }
          ];
        };
      };

    };
}
