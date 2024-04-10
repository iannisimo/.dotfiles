{...}: {}

# {
#   inputs,
#   pkgs,
#   config,
#   lib,
#   ...
# }: {
#   imports = [
#     "${inputs.nixpkgs-howdy}/nixos/modules/security/pam.nix"
#     "${inputs.nixpkgs-howdy}/nixos/modules/services/security/howdy/"
#   ];
    
#   services = {
#     howdy = {
#       enable = true;
#       package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
#       settings = {
#         video.device_path = "/dev/video2";
#         core.no_confirmation = true;
#         video.dark_threshold = 90;
#       };
#     };
#   };
# }