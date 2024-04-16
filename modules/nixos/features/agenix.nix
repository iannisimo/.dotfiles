{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];
}