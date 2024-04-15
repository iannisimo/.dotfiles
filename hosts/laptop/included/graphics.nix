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
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  specialisation."iGPU".configuration = {
    system.nixos.tags = [ "iGPU" ];
    hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];
    hardware.nvidia = lib.mkForce {};
    services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
    boot.extraModprobeConfig = ''
        options nouveau modeset=0
    '';
    boot.blacklistedKernelModules = lib.mkForce [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    services.udev.extraRules = lib.mkForce ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';
  };

  specialisation."dGPU".configuration = {
    system.nixos.tags = [ "dGPU" ];
    hardware.nvidia.prime = lib.mkForce {};
    hardware.nvidia.powerManagement = lib.mkForce {};
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
