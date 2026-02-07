{ inputs, ... }:
{
  flake.modules.homeManager."laurent@barbatruc" = {
    imports = with inputs.self.modules.homeManager; [
      tmux
    ];

  };

}
