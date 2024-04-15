{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    python3
  ];
}