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

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ pkgs.vscode-extensions.ms-vscode-remote.remote-ssh ]);
  };
}
