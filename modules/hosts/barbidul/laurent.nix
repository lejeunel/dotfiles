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

    # On this AMD ThinkPad the power button is a gpio-keys device that emits a
    # KEY_POWER event on every s2idle wake. niri handles the power key itself
    # (suspend by default), so each resume immediately re-suspends.
    # Let logind handle it instead (see configuration.nix).
    programs.niri.settings.input.power-key-handling.enable = false;

  };

}
