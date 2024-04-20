{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myNixOS.cloudflared.token = {
    type = lib.types.str;
    default = "";
    description = "Cloudflared tunnel token";
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
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token $(cat ${config.myNixOS.services.cloudflared})'";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}