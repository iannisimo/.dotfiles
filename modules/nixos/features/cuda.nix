{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git gitRepo gnupg autoconf curl
    procps gnumake util-linux m4 gperf unzip
    cudatoolkit linuxPackages.nvidia_x11
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
    ncurses5 stdenv.cc binutils
  ];
  environment.sessionVariables = {
    CUDA_PATH = [
      "${pkgs.cudatoolkit}"
    ];
    LD_LIBRARY_PATH = [
      "${pkgs.linuxPackages.nvidia_x11}/lib"
      "${pkgs.ncurses5}/lib"
    ];
    EXTRA_LDFLAGS = [
      "-L/lib"
      "-L${pkgs.linuxPackages.nvidia_x11}/lib"
    ];
    EXTRA_CCFLAGS = [
      "-I/usr/include"
    ];
  };
  config.nixpkgs.config.cudaSupport = true;
}