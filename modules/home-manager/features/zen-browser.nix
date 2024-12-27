{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  zen-browser = inputs.zen-browser.packages.${pkgs.system};
in {
  home.packages = [
    zen-browser
  ];
  # https://unix.stackexchange.com/a/752514
  # xdg = {
  #   enable =  true;
  #   mime.enable = lib.mkForce true;
  #   mimeApps = {
  #     enable = lib.mkForce true;
  #     defaultApplications = {
  #         "application/pdf" = "zen.desktop";
  #         "text/html" = "zen.desktop";
  #         "x-scheme-handler/http" = "zen.desktop";
  #         "x-scheme-handler/https" = "zen.desktop";
  #         "x-scheme-handler/about" = "zen.desktop";
  #         "x-scheme-handler/unknown" = "zen.desktop";
  #     };
  #   };
  # };
}
