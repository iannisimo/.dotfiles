{
  pkgs,
  config,
  lib,
  ...
}: {
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.tlp = {
      enable = true;
      settings = {
          INTEL_GPU_MIN_FREQ_ON_AC=300;
          INTEL_GPU_MIN_FREQ_ON_BAT=300;

          INTEL_GPU_MAX_FREQ_ON_AC=1150;
          INTEL_GPU_MAX_FREQ_ON_BAT=700;
          
          INTEL_GPU_BOOST_FREQ_ON_AC=1150;
          INTEL_GPU_BOOST_FREQ_ON_BAT=700;

          CPU_MIN_PERF_ON_AC = 20;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 10;

          CPU_BOOST_ON_AC=1;
          CPU_BOOST_ON_BAT=0;

          CPU_HWP_DYN_BOOST_ON_AC=1;
          CPU_HWP_DYN_BOOST_ON_BAT=0;

          CPU_DRIVER_OPMODE_ON_AC="active";
          CPU_DRIVER_OPMODE_ON_BAT="active";

          CPU_ENERGY_PERF_POLICY_ON_AC="performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT="power";

          CPU_SCALING_GOVERNOR_ON_AC="performance";
          CPU_SCALING_GOVERNOR_ON_BAT="powersave";
          
          # PCIE_ASPM_ON_AC="powersave";
          PCIE_ASPM_ON_BAT="powersupersave";
      };
  };
  security.sudo = {
    enable = lib.mkForce true;
    extraRules = [{
      commands = [
        {
          command = "${config.system.path}/bin/tlp";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${config.system.path}/bin/tlp-stat";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
}
