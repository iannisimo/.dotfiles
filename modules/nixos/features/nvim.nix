{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.nvim.overlays.default
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = nvim-pkg;
  };  
}
