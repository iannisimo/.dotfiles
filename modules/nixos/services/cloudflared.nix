{
  pkgs,
  config,
  lib,
  ...
}: {
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
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token $(cat ${config.age.secrets.cloudflared.path})'";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}