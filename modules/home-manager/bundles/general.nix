{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let 
  my_zotero = inputs.unstable-nixpkgs.legacyPackages.${pkgs.system}.zotero;
in {
  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neofetch
    lf
    ffmpeg
    coreutils
    killall 
    wget
    htop
    git
    zip
    unzip
    yt-dlp
    iftop
    nmap
    nix-search-cli
    bitwarden-cli
    my_zotero
    usbutils
    p7zip
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/.dotfiles";
  };
}
