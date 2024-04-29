{
  inputs,
  ...
}: {
  imports = [ inputs.connecttunnel-nix.nixosModule ];

  programs.connect-tunnel.enable = true;

  myNixOS.agenix.enable = true;
  age.secrets.unipi-ct = {
    file = ../agenix/secrets/unipi-ct.age;
    mode = "600";
    owner = "simone";
    group = "users";
  };
}