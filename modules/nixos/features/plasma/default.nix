{
  pkgs,
  config,
  lib,
  ...
}: {
  services.desktopManager.plasma6.enable = true;

  programs.kdeconnect = {
    enable = true;
  };
  programs.dconf.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  environment.systemPackages = with pkgs; [
    dbus
    xdg-utils
    xdg-desktop-portal
    libsForQt5.xdg-desktop-portal-kde
  ];
}