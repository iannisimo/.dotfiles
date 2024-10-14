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
      extraConfig = ''
        country=IT
        p2p_go_ht40=1
        device_name=DIRECT-SmallPP
      '';
      networks = {
        "eduroam" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="@USER_eduroam@"
            password="@PSK_eduroam@"
          '';
          extraConfig = ''
            ca_cert="${eduroam_cert}"
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "WiFightClub" = {
          psk = "@PSK_WiFightClub@";
        };
        "DIRECT-SmallPP" = {
          authProtocols = [ "WPA-PSK" ];
          psk = "@PSK_DIRECT_SmallPP@";
          extraConfig = ''
            bssid=40:ec:99:a7:39:d9
	          proto=RSN
	          pairwise=CCMP
	          mode=3
	          mesh_fwding=1
	          disabled=2
            auth_alg=OPEN
          '';
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
