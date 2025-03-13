{
  inputs,
  pkgs,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;  
  myQuickshell = quickshell.overrideDerivation (oldAttrs: {
    buildInputs = with pkgs; oldAttrs.buildInputs ++ [
        kdePackages.qtmultimedia
        kdePackages.qt5compat
      ];
    }
  );
in {
  home.packages = with pkgs; [
    myQuickshell
    unstable.matugen
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
