{
  flake.modules.homeManager.python =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [

        basedpyright
        qt6.qtwayland
        mesa
        libGL
        libxkbcommon

        (python313.withPackages (ps: [
          ps.isort
          ps.black
          ps.pyflakes
          ps.ipython
        ]))

      ];

      home.file.".ipython/profile_default/ipython_config.py".text = ''
        c = get_config()
        c.InteractiveShellApp.extensions = ["autoreload"]
        c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
      '';

      home.sessionVariables = {
        MPLBACKEND = "QtAgg";
      };

    };

}
