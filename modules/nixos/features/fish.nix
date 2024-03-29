{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    promptInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };
  environment.systemPackages = with pkgs; [
    grc
    fishPlugins.grc
    fishPlugins.z
    fishPlugins.done
    fishPlugins.sponge
    fishPlugins.puffer
    fishPlugins.pisces
  ];
}