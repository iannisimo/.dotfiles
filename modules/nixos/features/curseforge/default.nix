# {
#   pkgs,
#   lib,
#   config,
#   ...
# }: let
#   pname = "curseforge";
#   version = "0.244.4.r16117";
#   url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.zip";
# in pkgs.stdenv.mkDerivation {
#   inherit pname version;
#   src = pkgs.fetchurl {
#     url = url;
#     sha256 = "sha256-IaZbxnr+BO9iRaDnx3tQTjozr84ZbEVcOo7IpRijkvs=";
#   };

#   buildInputs = [
#     pkgs.unzip
#     pkgs.appimage-run
#   ];   

#   unpackPhase = ''
#     mkdir -p $out/
#     unzip $src -d $out >/dev/null
#     cf=$(find $out -name "CurseForge-*.AppImage")
#     mkdir -p /tmp/CurseForge
#     appimage-run -d -x /tmp/CurseForge/ $cf
#   '';

#   installPhase = ''
#     echo "installing"
#   '';
# }
{...}:{}