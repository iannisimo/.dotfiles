{
  pkgs,
  config,
  lib,
  ...
}: let
  eduroam_cert = pkgs.writeTextFile {
    name = "eduroam.cert";
    text = builtins.readFile ./extra/eduroam.cert;
  };
in {

  networking = {
    interfaces = {
      wlo1 = {
        useDHCP = true;
      };
    };
    hostName = "simonemsi";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
      #allowedTCPPorts = [  ];
      allowedUDPPorts = [ 40118 ];
      interfaces."wlo1" = {
        allowedTCPPorts = lib.mkForce [];
        allowedUDPPorts = lib.mkForce [];
      };
    };
  };

  systemd.network = {
    enable = true;
  };

  boot.initrd.systemd.network.wait-online.anyInterface = true;
}
