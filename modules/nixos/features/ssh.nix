{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.ssh;

  sshConfig = ''
    Host *
      IdentityFile ${cfg.rsa_key}
      IdentityFile ${cfg.ed25519_key}
    
    Host github.com
      HostName github.com
      User git

    Host lenovocasa
      ProxyCommand cloudflared access ssh --hostname ssh_casa.ianniciello.me
      User simone

    Host desktop
      ProxyCommand cloudflared access ssh --hostname ssh_desktop.ianniciello.me
      User simone

    Host debianrex
      ProxyCommand cloudflared access ssh --hostname debian.rexcam.xyz
      User hotel

    Host nixrex
      ProxyCommand cloudflared access ssh --hostname nix.rexcam.xyz
      User hotel
  '';
in {

  options.myNixOS.ssh = {
    rsa_key = lib.mkOption {
      type = lib.types.str;
      default = "~/.ssh/id_rsa";
      description = "Path to the RSA key file";
    };

    ed25519_key = lib.mkOption {
      type = lib.types.str;
      default = "~/.ssh/id_ed25519";
      description = "Path to the Ed25519 key file";
    };

    use_secret = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use the secret manager to store the SSH configuration";
    }; 
  };

  myNixOS.agenix.enable = cfg.use_secret;
  programs.ssh = {
    extraConfig = sshConfig + (if cfg.use_secret then ''
      Include ${config.age.secrets.ssh_config.path}
    '' else '''');
  };


  
}
