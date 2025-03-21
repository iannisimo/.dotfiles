{
  pkgs,
  lib,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small latexmk revtex4;
    }
  );
in {
  home.packages = [
    tex
    pkgs.zathura
  ];
}
