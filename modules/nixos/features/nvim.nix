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

  environment.systemPackages = with pkgs; [
    ( nvim-pkg.override {
      vimAlias = true;
      viAlias = true;
   })
  ];
}
