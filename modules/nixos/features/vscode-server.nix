{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; {
    nix-vscode-server
  };
}
