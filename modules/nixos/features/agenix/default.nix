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
    desktop-cloudflared = {
      file = ./secrets/desktop-cloudflared.age;
      mode = "777";
      owner = "cloudflared";
      group = "cloudflared";
    };

    ssh_config = {
      file = ./secrets/ssh_config.age;
      mode = "600";
      owner = "simone";
      group = "users";
    };
  };
  age.identityPaths = [
    "/home/simone/.ssh/id_ed25519"
    "/home/hotel/.ssh/id_ed25519"
  ];
}