{ stdenv, lib, pkgs, fetchFromGitHub }:

with lib;

let
in stdenv.mkDerivation rec {
  name = "doomemacs";

  src = fetchFromGitHub {
    owner = "doomemacs";
    repo = "doomemacs";
    rev = "v2.0.9";
    sha256 = "sha256-foiHHP85kZz4UwR8RfmB11xLoC+NbNdQ+sA2YJd/HqQ=";
  };

  dontBuild = true;
  installPhase = ''
    mkdir -p $out
    cp -rv $src/* $out
  '';
  postInstall = ''
    ln -sf $out /home/laurent/.config/emacs
  '';
}
