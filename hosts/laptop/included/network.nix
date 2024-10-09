{
  pkgs,
  config,
  lib,
  ...
}: let
  eduroam_cert = builtins.readFile ./extra/eduroam.cert;
in {

  age.secrets.wpa-supplicant-env = {
    file = ../../../modules/nixos/features/agenix/secrets/wpa-supplicant-env.age;
    mode = "644";
    owner = "root";
    group = "root";
  };


  networking = {
    hostName = "simonemsi";
    useNetworkd = true;

    wireless = {
      enable = true;
      environmentFile = config.age.secrets.wpa-supplicant-env.path;
      userControlled.enable = true;
      networks = {
        "eduroam" = {
          auth = ''
            key_mgmt=WPA-EAP
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="@USER_eduroam@"
            password="@PSK_eduroam@"
            ca_cert="${eduroam_cert}"
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "WiFightClub" = {
          psk = "@PSK_WiFightClub@";
        };
      };
    };

    networkmanager.enable = false;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 5900 ];
      allowedUDPPorts = [ 67 ];
      interfaces."wlo1" = {
        allowedTCPPorts = lib.mkForce [];
        allowedUDPPorts = lib.mkForce [];
      };
    };
  };

  systemd.network = {
    enable = true;
    networks = {
      "p2p-wlo1" = {
        matchConfig.Name = "p2p-wlo1-*";
        address = [ "192.168.4.1/30" ];
        networkConfig.DHCPServer = "yes";
      };
    };
  };
}
