{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pkgs.vscode.fhsWithPackages (ps: with ps; [ ms-vscode-remote.remote-ssh ])
  ];
}