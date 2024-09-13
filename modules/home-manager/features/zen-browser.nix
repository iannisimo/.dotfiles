{
  pkgs,
  inputs,
  ...
}:
let
  zen-browser = inputs.zen-browser.${pkgs.system}.specific;
in {
  home.packages = [
    zen-browser
  ];
}
