{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
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
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/.dotfiles";
  };
}
