{
  pkgs,
  config,
  lib,
  ...
}: {
  services.dbus.enable = true;
  programs.hyprland.enable = true;
  programs.light.enable = true;
}