{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python313Packages.ipython
  ];

  home.file.".ipython/profile_default/ipython_config.py".text = ''
    c = get_config()
    c.InteractiveShellApp.extensions = ["autoreload"]
    c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
  '';
}
