{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS.ssh;

  sshConfig = ''
    Host *
      IdentityFile ${cfg.ed25519_key}
      IdentityFile ${cfg.rsa_key}
      SetEnv TERM=xterm-256color
      ServerAliveCountMax 5
      ServerAliveInterval 60
    
    Host github.com
      HostName github.com
      User git

    Host lenovocasa
      ProxyCommand cloudflared access ssh --hostname ssh_casa.ianniciello.me
      User simone

    Host desktop
      ProxyCommand cloudflared access ssh --hostname ssh_desktop.ianniciello.me
      User simone

    Host desktop_hlt
      ProxyCommand cloudflared access ssh --hostname ssh_desktop.ianniciello.me
      User hlt

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

  age.secrets.ssh_config = lib.mkIf cfg.use_secret ({
    file = ./agenix/secrets/ssh_config.age;
    mode = "644";
    owner = "root";
    group = "root";
  });

  myNixOS.agenix.enable = if cfg.use_secret then true else false;

  programs.ssh = {
    extraConfig = (if cfg.use_secret then ''
      Include ${config.age.secrets.ssh_config.path}
      '' else "") + sshConfig;
  };
}
