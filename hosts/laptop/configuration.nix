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
  myNixOS.ios_debug.enable = true;

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
