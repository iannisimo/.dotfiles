{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.sessionVariables = rec {
    LD_LIBRARY_PATH=[
      "/run/opengl-driver/lib"
      "/run/opengl-driver-32/lib"
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtop-nvidia
    glxinfo
  ];


  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
