{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    # settings = {
    #   waybar = {
    #     position = "left";
    #     layer = "top";
    #     width = 40;


    #     modules-left = [
    #       "hyprland/workspaces"
    #     ];
        
    #     "hyprland/workspaces" = {
    #       format = "";
    #       on-scroll-up = "hyprctl dispatch workspace e+1";
    #       on-scroll-down = "hyprctl dispatch workspace e-1";
    #     };
    #   };
    # };
  };
}