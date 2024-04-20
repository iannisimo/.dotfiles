{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myNixOS.services.cloudflared.token = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Cloudflare Tunnel Token";
  };
  myNixOS.agenix.enable = true;

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };


  systemd.services.cloudflared_tunnel = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token $(cat ${config.myNixOS.services.cloudflared.token})'";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

  environment.systemPackages = with pkgs; [
    cloudflared
  ];
}