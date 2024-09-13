{
  pkgs,
  inputs,
  ...
}:
let
  zen-browser = inputs.zen-browser.packages.${pkgs.system}.specific;
in {
  home.packages = [
    zen-browser
  ];
}
