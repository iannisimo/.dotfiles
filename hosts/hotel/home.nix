{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  myHM = {
    bundles.general.enable = true;
  };

  myHM.git.enable = true;
  myHM.direnv.enable = true;

  home = {
    username = "hotel";
    homeDirectory = lib.mkDefault "/home/hotel";
    stateVersion = "23.11";

    packages = with pkgs; [
      comma
      dust
    ];
  };
}
