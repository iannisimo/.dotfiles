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

  networking = {
    hostName = "hotel_nixos";
    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.1.24";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];
  };

  # MyNixOS Config
  myNixOS = {
    userName = "hotel";
    userConfig = ./home.nix;
    userNixosSettings = {
      extraGroups = [
        "networkmanager"
        "wheel"
        "adbusers"
        "video"
        "input"
      ];
      shell = pkgs.fish;
    };
  };

  # Bundles
  myNixOS.bundles.home-manager.enable = true;

  # Features
  myNixOS.fish.enable = true;

  myNixOS.sysctl_sudo.enable = true;
  myNixOS.python.enable = true;

  myNixOS.vscode-server.enable = true;

  myNixOS.sonicwall.enable = true;

  # My Services
  myNixOS.services.cloudflared = {
    enable = true;
    token = config.age.secrets.hotel-cloudflared.path;
  };
  
  # Services
  
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true; # TODO: change
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

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    localuser = null;
  };

  services.acpid.enable = true;

  #  -----------------------------------
  # |            DANGER ZONE            |
  #  -----------------------------------

  system.stateVersion = "23.11";

  programs.nix-ld.enable = true;
}
