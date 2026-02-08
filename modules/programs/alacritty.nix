{
  flake.modules.homeManager.alacritty = {
    programs.alacritty = {
      enable = true;
      settings = {

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
        ];

        env.TERM = "alacritty-direct";
      };
    };
  };

}
