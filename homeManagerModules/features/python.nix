{ pkgs, ... }:

{
  home.packages = [

    pkgs.qt6.qtwayland
    pkgs.mesa
    pkgs.libGL
    pkgs.libxkbcommon

    (pkgs.python313.withPackages (ps: [
      ps.matplotlib
      ps.pyqt6
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

}
