{
  pkgs,
  config,
  lib,
  ...
}: {
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;
}
