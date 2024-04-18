{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    thunderbird
    telegram-desktop
    # gimp-with-plugins
    inkscape
    imagemagick
    nix-search-cli
  ];
}
