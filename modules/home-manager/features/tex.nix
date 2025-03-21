{
  pkgs,
  lib,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small latexmk;
    }
  );
in {
  home.packages = [
    tex
    pkgs.zathura
  ];
}
