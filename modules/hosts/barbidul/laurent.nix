{ inputs, ... }:
{
  flake.modules.homeManager."laurent@barbidul" = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop

      qwerty-fr

      dev

      aws

      drawing
      messaging
      office
    ];

  };

}
