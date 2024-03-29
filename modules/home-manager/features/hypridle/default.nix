{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = [
    inputs.hypridle.packages."${pkgs.system}".hypridle
  ];

  home.file."hypridle.conf" = {
    enable = true;
    source = ./config/hypridle.conf;
    target = ".config/hypr/hypridle.conf";
  };
}