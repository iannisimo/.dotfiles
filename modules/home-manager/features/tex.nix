{
  pkgs,
  lib,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full;
      # inherit (pkgs.texlive) scheme-small latexmk revtex4 mdframed lipsum pgfplots;
    }
  );
in {
  home.packages = [
    tex
    pkgs.zathura
  ];
}
