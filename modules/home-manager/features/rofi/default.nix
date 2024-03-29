{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./config/theme.rasi;
  };

  home.packages = with pkgs; [
    networkmanagerapplet
    networkmanager_dmenu
  ];
}