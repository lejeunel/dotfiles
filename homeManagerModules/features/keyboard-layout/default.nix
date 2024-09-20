{ config, inputs, lib, pkgs, vars, ... }:
let
  kbinput = "${(if vars.host == "tartopom" then
    "by-id/usb-DZTECH_DZ65RGBV3_vial:f64c2b3c-if02-event-kbd"
  else if vars.host == "barbatruc" then
    "by-path/platform-i8042-serio-0-event-kbd"
  else
    abort "keyboard-layout flake needs a valid hostname!")}";

  cfgANSI = ''
    (defcfg
      input (device-file "/dev/input/${kbinput}")
      output (uinput-sink "KMonad kbd")
      fallthrough true
      cmp-seq lctl
    )

    (defsrc
      esc
      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      caps a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      lctl met  lalt           spc            ralt rctl lft  up   down rght
    )

    (defalias
      alt (tap-next ralt (layer-toggle accent))
    )
    (defalias
      ç  RA-,
      €  RA-5
    )

    (deflayer default
      caps
      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      esc a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      rctl met  lalt           spc           @alt rctl lft  up   down rght
    )

    (deflayer accent
      _
      _    _    _    ê    _    @€   _    û    î    ô    _    _    _    _
      _    â    é    è    _    _    _    _    _    _    œ    _    _    _
      _    à    æ    ë    _    _    _    _    ï    _    _    _    _
      _    ä    _    @ç   _    _    _    _    _    _    _    _
      _    _    _              _              _    _    _    _    _    _
    )

  '';

  cfgISO = ''
    (defcfg
      input (device-file "/dev/input/${kbinput}")
      output (uinput-sink "KMonad kbd")
      fallthrough true
      cmp-seq lctl
    )

    (defalias
      alt (tap-next ralt (layer-toggle accent))
      sft (tap-next lsft (layer-toggle onshift))
      ç  RA-,
      €  RA-5
      qt (tap-macro ' spc)
      dqt (tap-macro " spc)
      crc (tap-macro ^ spc)
    )

    (defsrc
      esc
      grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab     q    w    e    r    t    y    u    i    o    p    [    ]
      caps    a    s    d    f    g    h    j    k    l    ;    '    \   ret
      lsft 102d z    x    c    v    b    n    m    ,    .    /    rsft
      lctl    lmet lalt            spc            ralt rmet cmp  rctl
    )


    (deflayer default
      caps
      grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab     q    w    e    r    t    y    u    i    o    p    [    ]
      esc     a    s    d    f    g    h    j    k    l    ;    @qt  \   ret
      @sft 102d z    x    c    v    b    n    m    ,    .    /    @sft
      lctl    lmet lalt            spc           @alt rmet cmp  rctl
    )

    (deflayer onshift
      _
      _       !    @    #    $    %    @crc &    *   \(    \)   \_   +    _
      _       Q    W    E    R    T    Y    U    I    O    P    {    }
      _       A    S    D    F    G    H    J    K    L    :    @dqt  |   _
      _    |  Z    X    C    V    B    N    M    <    >    ?    _
      _       _    _              _              _    _    _     _
    )

    (deflayer accent
      _
      _       _    _    ê    _    @€   _    û    î    ô    _    _    _    _
      _       â    é    è    _    _    _    _    _    _    œ    _    _
      _       à    æ    ë    _    _    _    _    ï    _    _    _    _   _
      _    _  ä    _    @ç   _    _    _    _    _    _    _    _
      _       _    _              _              _    _    _     _
    )

  '';

in {
  home.packages = with pkgs; [ kmonad ];
  home.file = {
    ".kmonad.kbd" = {
      text = if vars.host == "tartopom" then
        cfgANSI
      else if vars.host == "barbatruc" then
        cfgISO
      else
        "";
    };
  };
  systemd.user.services.keyboard-layout = {
    Unit = { Description = "Keyboard layout daemon"; };
    Install = { WantedBy = [ "default.target" ]; };
    Service = { ExecStart = "${pkgs.kmonad}/bin/kmonad %h/.kmonad.kbd"; };
  };
}
