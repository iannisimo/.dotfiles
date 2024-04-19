{
  inputs,
  ...
}: {
  imports = [ inputs.connecttunnel-nix.nixosModule ];

  programs.connect-tunnel.enable = true;
}