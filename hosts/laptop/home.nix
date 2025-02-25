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
  #myHM.tex.enable = true;
  myHM.git.enable = true;
  myHM.new_hyprland.enable = true;
  myHM.alacritty.enable = true;
  # myHM.spotify.enable = true;
  myHM.direnv.enable = true;
  myHM.zen-browser.enable = true;
  myHM.easyeffects.enable = true;
  myHM.discord.enable = true;
  myHM.livornowifi.enable = true;
  myHM.quickshell.enable = true;

  home = {
    username = "simone";
    homeDirectory = lib.mkDefault "/home/simone";
    stateVersion = "23.11";

    packages = with pkgs; [
      cloudflared
      comma
      libreoffice
      librecad
      # cura # waiting fix https://discourse.nixos.org/t/issue-building-nixos-due-to-sip-package/48702/5
      discord
      opera
      inotify-tools
      dust
      binwalk
    ];
  };
}
