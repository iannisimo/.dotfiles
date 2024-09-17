{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  home.file.".config/xkb/".source = ./config;
}
