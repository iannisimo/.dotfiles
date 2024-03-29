{
  pkgs,
  config,
  lib,
  ...
}: {
  services.xserver.desktopManager.enlightenment.enable = true;

  programs.kdeconnect = {
    enable = true;
  };
  programs.dconf.enable = true; 

  environment.systemPackages = with pkgs; [
    dbus
    xdg-utils
    xdg-desktop-portal
  ];
}