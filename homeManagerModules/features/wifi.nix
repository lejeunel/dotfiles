{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    iwd
    impala
  ];
}
