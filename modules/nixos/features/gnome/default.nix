{pkgs, ...}: {
  services.xserver.desktopManager.gnome.enable = true;


  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  programs.dconf.enable = true;

  services.udev.packages = with pkgs; [ 
    gnome-settings-daemon 
  ];
  services.gnome.gnome-keyring.enable = true;  
  services.dbus.enable = true;

  environment.systemPackages = with pkgs; [
    dbus
    xdg-utils
    adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome-tweaks
    xdg-desktop-portal
    xdg-desktop-portal-gnome
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    epiphany
    evince
    cheese
    gnome-music
    gnome-terminal
    geary
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ]);
}
