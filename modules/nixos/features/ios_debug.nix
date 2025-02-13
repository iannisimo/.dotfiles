{
  pkgs,
  ...
}: {
  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ios-webkit-debug-proxy
  ];

}
