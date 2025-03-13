{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let 

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
    unstable.zotero
    usbutils
    p7zip
    aria
    ripgrep
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/.dotfiles";
  };
}
