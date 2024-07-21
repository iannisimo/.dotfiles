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
    username = "hlt";
    homeDirectory = lib.mkDefault "/home/hlt";
    stateVersion = "23.11";

    packages = with pkgs; [
      inotify-tools
      dust
    ];
  };
}
