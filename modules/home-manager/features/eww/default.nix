{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    # package = inputs.eww.packages.${pkgs.system}.eww;
    package = pkgs.eww;
    configDir = ./config;
  };
  home.packages = with pkgs; [
    jq
    socat
  ];
}
