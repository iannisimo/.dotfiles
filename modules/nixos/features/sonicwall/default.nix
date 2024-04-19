{
  pkgs,
  lib,
  config,
  ...
}: {
  security.wrappers."AvConnect" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${( pkgs.callPackage ./package.nix { } )}/usr/local/Aventail/AvConnect";
  };
}