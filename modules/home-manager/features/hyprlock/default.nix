{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = [
    inputs.hyprlock.packages."${pkgs.system}".hyprlock
  ];

  home.file."hyprlock.conf" = {
    enable = true;
    source = ./config/hyprlock.conf;
    target = ".config/hypr/hyprlock.conf";
  };
}