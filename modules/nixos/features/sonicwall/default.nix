{
  inputs,
  config,
  ...
}: {
  imports = [ inputs.connecttunnel-nix.nixosModule ];

  myNixOS.agenix.enable = true;
  age.secrets.connect-tunnel = {
    file = ../agenix/secrets/connect-tunnel.age;
    mode = "600";
    owner = "root";
    group = "root";
  };

  programs.connect-tunnel = {
    enable = true;
    enableService = false;
    configFile = config.age.secrets.connect-tunnel.path;
  };
}