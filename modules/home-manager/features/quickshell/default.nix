{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    kdePackages.qtmultimedia
#    wl-clipboard
#    swww # wallpaper
#    cliphist
#    libnotify
#    inotify-tools
#    socat
#    brightnessctl
#    hyprshade
#    desktop-file-utils
#    hyprpicker
  ];
}
