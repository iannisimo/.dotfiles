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
        p2p_disabled=1
        # p2p_go_ht40=1
        # device_name=DIRECT-SmallPP
        # persistent_reconnect=1
      '';
      networks = {
        "HotelRex" = {
          pskRaw = "ext:PSK_HotelRex";
        };
        "SRV" = {
          pskRaw = "ext:PSK_SRV";
          extraConfig = ''
            scan_ssid=1
          '';
        };
        "UniPisa" = {
          authProtocols = [ "WPA-EAP" ];
          auth = ''
            eap=PEAP
            phase2="auth=MSCHAPV2"
            identity="s.ianniciello"
            password=ext:PSK_eduroam
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
            identity="s.ianniciello"
            password=ext:PSK_eduroam
          '';
          extraConfig = ''
            ca_cert="${eduroam_cert}"
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "StreamingZone" = {
          pskRaw = "ext:PSK_WiFightClub";
        };
        "WiFightClub" = {
          pskRaw = "ext:PSK_WiFightClub";
        };
        "Not-An-FBI-Van" = {
          pskRaw = "ext:PSK_Not_An_FBI_Van";
        };
        "ComuneLivornoWifi" = {
          authProtocols = [];
        };
        "MartinRouterStudio2.4" = {
          pskRaw = "ext:PSK_MRS";
        };
        "MartinRouterStudio" = {
          pskRaw = "ext:PSK_MRS";
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
  };
}
