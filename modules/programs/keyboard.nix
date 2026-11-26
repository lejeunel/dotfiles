{
  flake.modules.homeManager.qwerty-fr =
    { pkgs, vars, ... }:
    let
      kbinput = "${
        (
          if vars.host == "tartopom" then
            "by-id/usb-DZTECH_DZ65RGBV3_vial:f64c2b3c-if02-event-kbd"
          else if vars.host == "barbatruc" then
            "by-path/platform-i8042-serio-0-event-kbd"
          else if vars.host == "ulahup" then
            "by-path/platform-i8042-serio-0-event-kbd"
          else if vars.host == "barbidul" then
            "by-path/platform-i8042-serio-0-event-kbd"
          else
            abort "keyboard-layout flake needs a valid hostname!"
        )
      }";

      defalias = ''
        (defalias
          prt (tap-next sysrq (layer-toggle accent))
          cap (tap-next esc (layer-toggle accent))
          spm (tap-hold-next-release 200 spc (layer-toggle motion))

          ç  RA-,
          €  RA-5
          qt (tap-macro ' spc)
          dqt (tap-macro " spc)
          crc (tap-macro ^ spc)

          dia (tap-macro ")
        )
      '';

      defcfg = ''
        (defcfg
          input (device-file "/dev/input/${kbinput}")
          output (uinput-sink "KMonad kbd")
          fallthrough true
          allow-cmd true
          cmp-seq lctl
        )
      '';

      cfgANSI = ''
        ${defcfg}
        ${defalias}

        (defsrc
          esc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl met  lalt           spc           ralt sysrq rctl lft  up   down rght
        )


        (deflayer default
          caps
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          @cap a    s    d    f    g    h    j    k    l    ;    @qt    ret
          lsft z    x    c    v    b    n    m    ,    .    /    lsft
          met  lalt lctl           @spm           lctl  lalt @prt lft  up   down rght
        )

        (deflayer motion
          _
          _  _    _    _    _    _    _    _    _    _    _    _    _    _
          _  _    _    _    _    _    _  home   pgdn pgup end       _    _  _
          _  _    _    _    _    _    _ left down up right    _        _
          _     _    _   _    _    _    _ A-b  A-a  A-e    A-f      _
          _   _    _           _           _    _    _    _    _   _    _
        )

        (deflayer accent
          _
          _    _    _    ê    _    @€   _    û    î    ô    _    _    _    _
          _    â    é    è    _    _    _    ù    _    _    œ    _    _    _
          _    à    æ    ë    _    _    _    _    ï    _    _    _    _
          _    ä    _    @ç   _    _    _    _    _    _    _    _
          _    _    _              _              _    _    _    _    _    _    _
        )
      '';

    in
    {
      home.packages = with pkgs; [
        kmonad
        wtype
      ];
      home.file = {
        ".kmonad.kbd" = {
          text = cfgANSI;
        };
      };
      systemd.user.services.keyboard-layout = {
        Unit = {
          Description = "Keyboard layout daemon";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = "${pkgs.kmonad}/bin/kmonad %h/.kmonad.kbd";
        };
      };

    };
}
