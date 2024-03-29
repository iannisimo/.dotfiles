{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Simone";
    userEmail = "iannisimo@gmail.com";
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };

      init = {
        "defaultBranch" = "main";
      };
    };
  };
}