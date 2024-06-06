{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  myHM = {
    bundles.general.enable = true;
    bundles.desktop.enable = true;
    bundles.wayland.enable = true;
  };

  myHM.gnome.enable = true;
  myHM.tex.enable = true;
  myHM.git.enable = true;
  myHM.hyprland.enable = true;
  myHM.alacritty.enable = true;
  myHM.spotify.enable = true;
  myHM.nvim.enable = true;
  myHM.direnv.enable = true;

  myHM.code.enable = true;

  home = {
    username = "simone";
    homeDirectory = lib.mkDefault "/home/simone";
    stateVersion = "23.11";

    packages = with pkgs; [
      cloudflared
      comma
      libreoffice
      librecad
      cura
      discord
      opera
      inotify-tools
      dust
    ];
  };
}