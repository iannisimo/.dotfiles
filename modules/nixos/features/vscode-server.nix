{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];
  services.vscode-server = {
    enable = true;
    enableFHS = true;
  };
}
