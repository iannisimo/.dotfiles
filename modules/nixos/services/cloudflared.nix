{
  pkgs,
  config,
  lib,
  ...
}: let
  ageFile = config.myNixOS.services.cloudflared.age-file;
in {
  options.myNixOS.services.cloudflared.age-file = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Age file for the cloudflared tunnel token";
  };

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };

  myNixOS.agenix.enable = true;
  age.secrets."${ageFile}" = {
    file = ../features/agenix/secrets/${ageFile};
    mode = "600";
    owner = "cloudflared";
    group = "cloudflared";
  };


  systemd.services.cloudflared_tunnel = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token $(cat ${config.age.secrets."${ageFile}".path})'";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

  environment.systemPackages = with pkgs; [
    cloudflared
  ];
}