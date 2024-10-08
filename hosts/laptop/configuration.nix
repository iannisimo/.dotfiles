{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  ... 
}: 
{
  imports = [
    outputs.nixosModules.default

    ./hardware-configuration.nix
  ]
  ++ (myLib.filesIn ./included);

  # Systemd-boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  age.secrets.wpa-supplicant-env = {
    file = "../../modules/nixos/features/agenix/secrets/wpa-supplicant-env.age";
    mode = "644";
    owner = "root";
    group = "root";
  };

  networking = {
    hostName = "simone_msi";
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
            ca_cert=/home/simone/Downloads/ca.cert
            altsubject_match="DNS:aaas1.unipi.it"
          '';
        };
        "WiFightClub" = {
          auth = ''
            key_mgmt=WPA2-PSK
            psk=@PSK_WiFightClub@
          '';
        };
      };
    };
    networkmanager.enable = false;
    #networkmanager = {
    #  enable = false;
    #  wifi.macAddress = "stable-ssid"; # Set to 'random' to change on every connection
    #  unmanaged = [ "wlo1_ap" ];
    #};
    #wlanInterfaces = {
    #  wlo1_sta = {
    #    device = "wlo1";
    #    mac = "12:34:56:78:ab:cd";
    #    type = "managed";
    #  };
    #  wlo1_ap = {
    #    device = "wlo1";
    #    mac = "12:34:56:78:ab:ce";
    #    type = "managed";
    #  };
    #};
    #interfaces = {
    #  wlo1_ap.ipv4.addresses = [
    #    { address = "192.168.12.1"; prefixLength = 24; }
    #  ];
    #};
    #firewall.interfaces.wlo1_ap.allowedTCPPorts = [ 5900 ];
  };

  #services.hostapd = {
  #  enable = true;
  #  radios."wlo1_ap" = {
  #    networks."wlo1_ap" = {
  #      ssid = "vnc_ap";
  #      authentication = {
  #        mode = "wpa2-sha256";
  #        wpaPassword = "testing_should_put_in_secret";
  #      };
  #    };
  #  };
  #};

  # MyNixOS Config
  myNixOS = {
    userName = "simone";
    userConfig = ./home.nix;
    userNixosSettings = {
      extraGroups = [
        "networkmanager"
        "wheel"
        "adbusers"
        "video"
        "input"
        "dialout"
        "disk"
      ];
      shell = pkgs.fish;
    };
  };

  # Bundles
  myNixOS.bundles.desktop.enable = true;
  myNixOS.bundles.home-manager.enable = true;

  # Programs
  programs.kdeconnect = {
    enable = true;
  };   
  
  programs.adb = {
    enable = true;
  };

  # Features
  myNixOS.fish.enable = true;
  myNixOS.sddm.enable = true;
  myNixOS.hyprland.enable = true;
  # - GNOME
  # myNixOS.gdm.enable = true;
  myNixOS.gnome.enable = true;
  myNixOS.sysctl_sudo.enable = true;
  myNixOS.cuda.enable = true;
  myNixOS.python.enable = true;

  myNixOS.vscode-server.enable = true;
  myNixOS.code.enable = true;
  myNixOS.clion.enable = false; # Do not enable; it's a trap
  myNixOS.nvim.enable = true;

  myNixOS.sonicwall.enable = true;

  myNixOS.ssh.enable = true;

  # disabledModules = [
  #   "security/pam.nix"
  # ];
  # myNixOS.howdy.enable = true;


  # My Services
  myNixOS.services.tlp.enable = true;
  myNixOS.services.isw.enable = true;
  
  # Services
  
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
        enable = true;
        addresses = true;
        userServices = true;
        workstation = true;
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    localuser = null;
  };

  services.blueman.enable = true;
  services.printing.enable = true;
  services.acpid.enable = true;

  #  -----------------------------------
  # |            DANGER ZONE            |
  #  -----------------------------------

  system.stateVersion = "23.11";

}
