{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.system}".default
  ];
  
  age.identityPaths = [
    "/home/simone/.ssh/id_ed25519"
    "/home/hotel/.ssh/id_ed25519"
  ];
}