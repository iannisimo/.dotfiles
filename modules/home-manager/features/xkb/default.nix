{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  home.file.".config/kbd/".source = ./config;
}
