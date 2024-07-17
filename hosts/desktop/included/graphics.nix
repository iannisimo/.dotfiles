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
    nvtopPackages.nvidia
    glxinfo
  ];


  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  
  hardware.graphics = {
    enable = true;
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
