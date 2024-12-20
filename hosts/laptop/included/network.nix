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
      secretsFile = config.age.secrets.wpa-supplicant-env.path;
      userControlled.enable = true;
      extraConfig = ''
        country=IT
        p2p_go_ht40=1
        device_name=DIRECT-SmallPP
        persistent_reconnect=1
      '';
      networks = {
        "UniPisa" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="ext:USER_eduroam"
            password="ext:PSK_eduroam"
          '';
          extraConfig = ''
            ca_cert="${eduroam_cert}"
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "eduroam" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="ext:USER_eduroam"
            password="ext:PSK_eduroam"
          '';
          extraConfig = ''
            ca_cert="${eduroam_cert}"
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "WiFightClub" = {
          psk = "ext:PSK_WiFightClub";
        };
        #"DIRECT-SmallPP" = {
        #  authProtocols = [ "WPA-PSK" ];
        #  psk = "ext:PSK_DIRECT_SmallPP";
        #  extraConfig = ''
        #    bssid=40:ec:99:a7:39:d9
	      #    proto=RSN
	      #    pairwise=CCMP
	      #    mode=3
	      #    mesh_fwding=1
        #    disabled=2
        #    auth_alg=OPEN
        #  '';
        #};
        "Not-An-FBI-Van" = {
          psk = "ext:PSK_Not_An_FBI_Van";
        };
        "ComuneLivornoWifi" = {
          authProtocols = [];
        };
      };
    };

    networkmanager = {
      enable = true;
      unmanaged = [ "wlo1" ];
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
    #networks = {
    #  "p2p-wlo1" = {
    #    matchConfig.Name = "p2p-wlo1-*";
    #    address = [ "192.168.4.1/30" ];
    #    networkConfig.DHCPServer = "yes";
    #  };
    #};
  };
}
