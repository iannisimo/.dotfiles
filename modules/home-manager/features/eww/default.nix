{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = ./config;
  };
  home.packages = with pkgs; [
    jq
    socat
  ];
}