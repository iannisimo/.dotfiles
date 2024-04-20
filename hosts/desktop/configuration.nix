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
    hostName = "simone_desktop";
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };
  };

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

  myNixOS.sysctl_sudo.enable = true;
  myNixOS.cuda.enable = true;
  myNixOS.python.enable = true;

  myNixOS.code.enable = true;
  myNixOS.vscode-server.enable = true;

  myNixOS.sonicwall.enable = true;

  # My Services
  # myNixOS.services.tlp.enable = true;
  myNixOS.services.cloudflared = {
    enable = true;
    token = config.age.secrets.desktop-cloudflared.path;
  };
  
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

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    localuser = null;
  };

  services.blueman.enable = true;
  services.printing.enable = true;
  services.acpid.enable = true;

  # Autologin for Desktop Environment
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "simone";
  };

  #  -----------------------------------
  # |            DANGER ZONE            |
  #  -----------------------------------

  system.stateVersion = "23.11";

  programs.nix-ld.enable = true;
}
