{
  pkgs,
  config,
  lib,
  ...
}: {
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
         governor = "powersave";
         turbo = "never";
      };
      charger = {
         governor = "performance";
         turbo = "auto";
      };
    };
  };
  services.thermald.enable = true;
}
