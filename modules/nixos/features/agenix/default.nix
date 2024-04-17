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

  age.secrets = {
    cloudflared = {
      file = ./secrets/cloudflared.age;
      mode = "777";
      owner = "cloudflared";
      group = "cloudflared";
    };
  };
  age.identityPaths = [
    "/home/simone/.ssh/id_ed25519"
  ];
}