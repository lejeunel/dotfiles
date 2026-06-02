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
          else
            abort "keyboard-layout flake needs a valid hostname!"
        )
      }";

      defalias = ''
        (defalias
          alt (tap-next ralt (layer-toggle accent))
          sft (tap-next lsft (layer-toggle upper))
          sfg (tap-next lsft (layer-toggle greek-upper))
          rcd (tap-hold 200 rctl (layer-switch greek))
          rcg (tap-hold 200 rctl (layer-switch default))

          ç  RA-,
          €  RA-5
          qt (tap-macro ' spc)
          dqt (tap-macro " spc)
          crc (tap-macro ^ spc)

          dia (tap-macro ")
          alp (cmd-button "wtype α")
          si_ (cmd-button "wtype ς")
          eps (cmd-button "wtype ε")
          rho (cmd-button "wtype ρ")
          tau (cmd-button "wtype τ")
          ips (cmd-button "wtype υ")
          the (cmd-button "wtype θ")
          iot (cmd-button "wtype ι")
          omi (cmd-button "wtype ο")
          pi (cmd-button "wtype π")
          sig (cmd-button "wtype σ")
          del (cmd-button "wtype δ")
          phi (cmd-button "wtype φ")
          gam (cmd-button "wtype γ")
          eta (cmd-button "wtype η")
          xi (cmd-button "wtype ξ")
          kap (cmd-button "wtype κ")
          lam (cmd-button "wtype λ")
          zet (cmd-button "wtype ζ")
          khi (cmd-button "wtype χ")
          psi (cmd-button "wtype ψ")
          ome (cmd-button "wtype ω")
          bet (cmd-button "wtype β")
          nu (cmd-button "wtype ν")
          mu (cmd-button "wtype μ")

          ALP (cmd-button "wtype Α")
          EPS (cmd-button "wtype Ε")
          RHO (cmd-button "wtype Ρ")
          TAU (cmd-button "wtype Τ")
          IPS (cmd-button "wtype Υ")
          THE (cmd-button "wtype Θ")
          IOT (cmd-button "wtype Ι")
          OMI (cmd-button "wtype Ο")
          PI (cmd-button "wtype Π")
          SIG (cmd-button "wtype Σ")
          DEL (cmd-button "wtype Δ")
          PHI (cmd-button "wtype Φ")
          GAM (cmd-button "wtype Γ")
          ETA (cmd-button "wtype Η")
          XI  (cmd-button "wtype Ξ")
          KAP (cmd-button "wtype Κ")
          LAM (cmd-button "wtype Λ")
          ZET (cmd-button "wtype Ζ")
          KHI (cmd-button "wtype Χ")
          PSI (cmd-button "wtype Ψ")
          OME (cmd-button "wtype Ω")
          BET (cmd-button "wtype Β")
          NU  (cmd-button "wtype Ν")
          MU  (cmd-button "wtype Μ")
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
          lctl met  lalt           spc            ralt rctl lft  up   down rght
        )


        (deflayer default
          caps
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          esc a    s    d    f    g    h    j    k    l    ;    @qt    ret
          @sft z    x    c    v    b    n    m    ,    .    /    @sft
          lctl met  lalt           spc           @alt @rcd lft  up   down rght
        )

        (deflayer upper
          _
          ~    !    @    #    $    %   @crc  &    *    \(    \)  \_   +    _
          _    Q    W    E    R    T    Y    U    I    O    P    {    }    |
          _    A    S    D    F    G    H    J    K    L    :    @dqt    _
          _    Z    X    C   V     B    N    M    <    >    ?    _
          _    _    _              spc            _    _    _    _    _    _
        )

        (deflayer accent
          _
          _    _    _    ê    _    @€   _    û    î    ô    _    _    _    _
          _    â    é    è    _    _    _    ù    _    _    œ    _    _    _
          _    à    æ    ë    _    _    _    _    ï    _    _    _    _
          _    ä    _    @ç   _    _    _    _    _    _    _    _
          _    _    _              _              _    _    _    _    _    _
        )

        (deflayer greek
          _
          _    _    _    _    _    _   _    _   _   _   _    _    _    _
          _    ;    @si_ @eps @rho @tau @ips @the   @iot    @omi    @pi    _    _    _
          _    @alp @sig @del @phi @gam @eta @xi    @kap    @lam    _    _    _
          @sfg @zet @khi @psi @ome @bet @nu  @mu    _       _       _    @sfg
          _    _    lalt              _              _    @rcg    _    _    _    _
        )
        (deflayer greek-upper
          _
          _    _    _    _    _    _   _    _   _   _   _    _    _    _
          _    .    @SIG @EPS @RHO @TAU @IPS @THE   @IOT    @OMI    @PI    _    _    _
          _    @ALP @SIG @DEL @PHI @GAM @ETA @XI    @KAP    @LAM    @dia   @dqt    _
          _    @ZET @KHI @PSI @OME @BET @NU  @MU    _       _    _    _
          _    _    lalt              _              _    @rcg    _    _    _    _
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
